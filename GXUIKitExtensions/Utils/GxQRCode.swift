//
//  GxQRCode.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 8/29/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public typealias 🔳 = QRCode
/// QRCode generator
public struct QRCode {
    
    /**
    The level of error correction.
    
    - Low:      7%
    - Medium:   15%
    - Quartile: 25%
    - High:     30%
    */
    public enum ErrorCorrection: String {
        case Low = "L"
        case Medium = "M"
        case Quartile = "Q"
        case High = "H"
    }
    
    /// Data contained in the generated QRCode
    public let data: Data
    
    /// Foreground color of the output
    /// Defaults to black
    public var color = CIColor(red: 0, green: 0, blue: 0)
    
    /// Background color of the output
    /// Defaults to white
    public var backgroundColor = CIColor(red: 1, green: 1, blue: 1)
    
    /// Size of the output
    public var size = CGSize(width: 200, height: 200)
    
    /// The error correction. The default value is `.Low`.
    public var errorCorrection = ErrorCorrection.Low
    
    // MARK: Init
    
    public init(_ data: Data) {
        self.data = data
    }
    
    public init?(_ string: String, _ size:CGSize = CGSize(width: 200, height: 200)) {
        if let data = string.data(using: .isoLatin1) {
            self.data = data
            self.size = size
        } else {
            return nil
        }
    }
    
    public init?(_ url: URL) {
        if let data = url.absoluteString.data(using: .isoLatin1) {
            self.data = data
        } else {
            return nil
        }
    }
    
    // MARK: Generate QRCode
    
    /// The QRCode's UIImage representation
    public var image: UIImage? {
        guard let ciImage = ciImage else { return nil }
        
        // Size
        let ciImageSize = ciImage.extent.size
        let widthRatio = size.width / ciImageSize.width
        let heightRatio = size.height / ciImageSize.height
        
        return ciImage.nonInterpolatedImage(withScale: Scale(dx: widthRatio, dy: heightRatio))
    }
    
    /// The QRCode's CIImage representation
    public var ciImage: CIImage? {
        // Generate QRCode
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue(self.errorCorrection.rawValue, forKey: "inputCorrectionLevel")
        
        // Color code and background
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        return colorFilter.outputImage
    }
}

public extension UIImageView {
    
    /// Creates a new image view with the given QRCode
    ///
    /// - parameter qrCode:      The QRCode to display in the image view
    convenience init(qrCode: QRCode) {
        self.init(image: qrCode.image)
    }
}

internal typealias Scale = (dx: CGFloat, dy: CGFloat)

internal extension CIImage {
    
    /// Creates an `UIImage` with interpolation disabled and scaled given a scale property
    ///
    /// - parameter withScale:  a given scale using to resize the result image
    ///
    /// - returns: an non-interpolated UIImage
    func nonInterpolatedImage(withScale scale: Scale = Scale(dx: 1, dy: 1)) -> UIImage? {
        guard let cgImage = CIContext(options: nil).createCGImage(self, from: self.extent) else { return nil }
        let size = CGSize(width: self.extent.size.width * scale.dx, height: self.extent.size.height * scale.dy)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
