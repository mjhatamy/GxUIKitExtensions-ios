//
//  UIImage+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

private class FrameworkBundleClass: NSObject {
}

let frameworkBundle: Bundle = Bundle(for: FrameworkBundleClass.self)

public extension UIImage{
    
    class var getTickImage:UIImage? {
        struct TickImage {
            static func getImageBase64() -> String {
                let scale = UIScreen.main.scale
                if scale <= 1.0 {
                    return image_100x100_Base64
                }else if scale <= 2.0 {
                    return image_100x100_Base64_2x
                }else{
                    return image_100x100_Base64_3x
                }
            }
            fileprivate static let image_100x100_Base64 = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAVpJREFUeNpi/P//P8NAAiaGAQYj1wH/oDSLu7s7XS3+DcSqrKyKflw8vhM+vp9Ed5/zMTBI7eMXvvRDXOZ/BwfXDBZ6Wi7FwiK1Xlxquxk7p+7P//8Yfv3ieks/y5lZpE5Ky138r6T+/7eS2v8CfsHiAbO8iF+wdNTyUctHLad6hUC25fIsrLJ7JGX2xPLwRQ9IsB+Skj32X1n9/2dF1V/hPLwhdI9zB04uuztyik//ATV/UVT9TYojqJbgDNnZDR7KKT0nxRFUT+3G7ByGQEe8gDoCb3TQLKsR4wia53OoI55jcwTdChmQIx4hOSKIm8dPnJlZ7AQ9SzioI8DR8UJe+etlGYW7f4BsuhavsOgAWfpdUZX+ZTsIqANz6XVhsZffxKX/pzGzUt1yRjc3N7wKfgK7bnacnGaGbByGkz6+n8nGyEhdBxDbN/xHo14ME9UVjvYNSQQAAQYA8G36ibQL7fAAAAAASUVORK5CYII="
            
            fileprivate static let image_100x100_Base64_2x = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZJREFUeNrsm81vEkEUwN8MsOwW2FIxrNWkBQr2RjzUtB486cXEgBeNiT1I0oO2nvwDPJr20mii6Unix8FTY/yIHtSjJvXqzfSoJtZqtZVCC+w4w0fD2oUCAgudmWQh2QOzv9+892Z2dkGEEOC5YeC8CQFCgBAgBAgBPDf73NwcF6BsvbMFBE4promlTPrDNiE6Roiv0T4HkPh+QMvdtDvvchfqlz39iXQwom8EI0QPjZLbPv8tlv82PuDVxMJBLZkDQFmWCvQ4qSgTAbtjGHMED9nSfY8NENAaAMvZ7Kd9D0/DnrCw/xkIF471QIRsh46SadV7hQd43Qz+muq9ykPBI5zC1xj5fj5GnuuwFzkv4EXOi5HnZuQFvIAX8NzAqwJewAv4DsB7MVa4hb/kVs8vD4U+npCVKHf38xdcntifYCSTpZ18HR75YpUES6a6GdU7tRYIp8udsgsoSpCj+x6eNnzW5Y6pGMvlLeM0/R7A+PCiduRVpyQUt679hq1rOyCQMYLrP1am7/z+tdCuvm1PUhuLAYc0NO5UjmVKnbML8WDsibk88fdb6Tefc7lv7YXXLIEvCMgC5F9upp6FJcfIcacSNZPwrk0SWNhT+HvlJzadhi8IYB95APJiM/U07DCXEC9IyLRUQhHebyn8jgCDBKmaBDdNh9ZI6BZ4g4B6JMRaIKEEnzTCA4XHHYffJaBSQoRKGKsiodl0qICHboA3FVCW8LxmTWg8EszD3lr4qgJ2p4P8X+lQE36Vwq9bA19TgHF2kJqWsAf8jJXwewqoV0K1mlCz4Fk88nULMBZGybQwxk0kdHPYNyyg3sJIJbymElZ6YeQbFlDPOuF0X98ZzWYfuDHgmweEzKt9F8Gz1tSbgk6E8H3/oQcXXerkmp7fOW9HdDVHj01dB718rgumupZFwF6LJQbN3r4iPQLftABDTfgnHaCH4FvSWDo89g8+IqHRip2cMB+PqA0StMGHTMJ6MMIXfGVBnZfk5KpPy00CmuqZi56dnW3JD+VpDaAzgG1cVsbeplNLEp1gUA+8jo7E/wY5b0KAECAECAFCAM/trwADAPPagfIr4iTPAAAAAElFTkSuQmCC"
            
            fileprivate static let image_100x100_Base64_3x = "iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADimHc4AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAABLdJREFUeNrsnc1PE0EYh3eWLS3bUhPSsrRIBARJPGpMjB7UeFGjVD0YP+IHBz3pn+LVKI2JQIwSPxIi2otGLwjRi9FoYryoUSPGzwqWlnbX2YWaKtTuQnd2uvt7kwZCoOw+z8w778xOd4mmaQLCuSAQAAEQgIAACEBAAAQgIAACEBAAAQh2IU1MTICCzZGnjTwsivWz9NsZTVXrBAIoLCMgCHIqotwbaooOgQbjCAlEHlXiqUJHt6a/LkWUZB2wsIlGUZRvt7Sm1M412tf2LuOldfZoA9GWpETm0hBk2Aj/anPsxk45uOO7qv75+QwdDzYGGta1SVI8lZm+AwEM4f8tIbC+p97fKQIXW/hG6UmroIymqY+zmUeohxyA7ydEO/1l8ngy/WMIAljDF4l25vOnE/3p74PGTBjomMJXKfy+InwIcBg+BDiUdiCAg5YPAbbDFyh88b/wIcBe+GXTDgRw0PIhwNaWP0lb/o9BM+8LAVWvdszDhwBGpSYEMCk1J/ustHwI4AA+BDiQ8yHAoWoHAjhr+RDAAXwIYDzgQgBHLR8COIDvaQE8wPesAF7ge1IAT/A9J8AUfELhCxT+F+sLaxBQY/A9I2AOfpzClyvBVyn8PlbwPSGA15ZfjAWbc2UiSkqdFAR8BwT4CSGXldjgg3jb/XbJ1+SOtMMv/L8E6PAHm2MXE3LwUJfPt2GkJX6rViXo8IfN5XxH4f8ZA4rwDwQb+76pheJJCC9y2bHExw+9r/OzX1044FL49tf5FQUEac7vjyrnDofCJ4vwS05Gl/CQSthTCxKs5Xzn4RsC7sZW3tzaIO9LlzngEgm7qYRvLoGvLykP8HDcYurX9J0pVc0UP7X3b/ykJ7O23r9ppKV1lNcxYQktf4CXYzeoHwmF9ySjyjWagPyzZW5dMNcTcrQnvOcqHZmGT9is7Sx5InY0FE7QsWB4lkrI14iEWoe/YCZ8rDGcOB9Rhiv3BOfHBDfAX3QpQpdwIcJ3TzDgKxR+Q23DL7sWdHReAo9jgpvglxVQlNBPJeTNpSMmEkzBZ3gxxVYBRjqiA/P5KB89wW0t35QAixLGqARbli3cCt+UAKfHBLdUO8sSUDpPyDOU4Hb4lgSUlqiVJDynEvYuU4IF+FXfLsitAGvV0dJ7gptz/rIF2C3BWqnp7MUUxwTYJaFaH//3hABr1VHlyRpvO9ZqQkC1SlQrd5py+houdwKK1ZHJVdSx3o8fet+USLAAn/mmqZoRYKUnPKfpaO98OgqLYvBKc+y6V+HrUbXbVj7NZV++LeSfJeTQPkKItBjOHBWzUvK1bQnIm5/ksuNnI83J3XJwl4m040r4Ve0BViZrFKp+78zpACHBbJnfcWvOt12A2TFB3xGmlvl7t6cd2wWYnSeUneEK3oBvqwBDgokFvEXguz7tMBNgRYIX4TMRYCYdeS3tMBfwv57A215NV4d+eTPT0Z2Z6ug2HmaQpl+zHWsKp8IrjoEOozggh3Z8XrU6nWnv1mbau7InG8MHQYVxbPfVb3sVb3t5KNCw3+ssyPj4OPN/qj9BorVOCr0r5KfobNjTN6zAg9wgAAJAAQIgAAEBEICAAAhAQAAEICDAO/FbgAEAkScKeFjwMcMAAAAASUVORK5CYII="
        }
        
        guard let decodedData = Data(base64Encoded: TickImage.getImageBase64() ) else{
            return nil
        }
        return UIImage(data: decodedData)
    }
    
    
    
    class func generateBackArrowImage(color: UIColor) -> UIImage? {
        return UIImage.generateImage(CGSize(width: 13.0, height: 22.0), rotatedContext: { size, context in
            context.clear(CGRect(origin: CGPoint(), size: size))
            context.setFillColor(color.cgColor)
            
            context.translateBy(x: 0.0, y: -UIScreenPixel)
            
            let _ = try? UIImage.drawSvgPath(context, path: "M3.60751322,11.5 L11.5468531,3.56066017 C12.1326395,2.97487373 12.1326395,2.02512627 11.5468531,1.43933983 C10.9610666,0.853553391 10.0113191,0.853553391 9.42553271,1.43933983 L0.449102936,10.4157696 C-0.149700979,11.0145735 -0.149700979,11.9854265 0.449102936,12.5842304 L9.42553271,21.5606602 C10.0113191,22.1464466 10.9610666,22.1464466 11.5468531,21.5606602 C12.1326395,20.9748737 12.1326395,20.0251263 11.5468531,19.4393398 L3.60751322,11.5 Z ")
        })
    }

    class func generateImage(_ size: CGSize, opaque: Bool = false, scale: CGFloat? = nil, rotatedContext: (CGSize, CGContext) -> Void) -> UIImage? {
        let selectedScale = scale ?? ScreenDeviceScale
        let scaledSize = CGSize(width: size.width * selectedScale, height: size.height * selectedScale)
        let bytesPerRow = (4 * Int(scaledSize.width) + 15) & (~15)
        let length = bytesPerRow * Int(scaledSize.height)
        let bytes = malloc(length)!.assumingMemoryBound(to: Int8.self)
        
        guard let provider = CGDataProvider(dataInfo: bytes, data: bytes, size: length, releaseData: { bytes, _, _ in
            free(bytes)
        })
            else {
                return nil
        }
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | (opaque ? CGImageAlphaInfo.noneSkipFirst.rawValue : CGImageAlphaInfo.premultipliedFirst.rawValue))
        
        guard let context = CGContext(data: bytes, width: Int(scaledSize.width), height: Int(scaledSize.height), bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: DeviceColorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        
        context.scaleBy(x: selectedScale, y: selectedScale)
        context.translateBy(x: size.width / 2.0, y: size.height / 2.0)
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: -size.width / 2.0, y: -size.height / 2.0)
        
        rotatedContext(size, context)
        
        guard let image = CGImage(width: Int(scaledSize.width), height: Int(scaledSize.height), bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: bytesPerRow, space: DeviceColorSpace, bitmapInfo: bitmapInfo, provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
            else {
                return nil
        }
        
        return UIImage(cgImage: image, scale: selectedScale, orientation: .up)
    }
    
    class func drawSvgPath(_ context: CGContext, path: StaticString, strokeOnMove: Bool = false) throws {
        var index: UnsafePointer<UInt8> = path.utf8Start
        let end = path.utf8Start.advanced(by: path.utf8CodeUnitCount)
        while index < end {
            let c = index.pointee
            index = index.successor()
            
            if c == 77 { // M
                let x = try CGFloat.readCGFloat(&index, end: end, separator: 44)
                let y = try CGFloat.readCGFloat(&index, end: end, separator: 32)
                
                //print("Move to \(x), \(y)")
                context.move(to: CGPoint(x: x, y: y))
            } else if c == 76 { // L
                let x = try CGFloat.readCGFloat(&index, end: end, separator: 44)
                let y = try CGFloat.readCGFloat(&index, end: end, separator: 32)
                
                //print("Line to \(x), \(y)")
                context.addLine(to: CGPoint(x: x, y: y))
                
                if strokeOnMove {
                    context.strokePath()
                    context.move(to: CGPoint(x: x, y: y))
                }
            } else if c == 67 { // C
                let x1 = try CGFloat.readCGFloat(&index, end: end, separator: 44)
                let y1 = try CGFloat.readCGFloat(&index, end: end, separator: 32)
                let x2 = try CGFloat.readCGFloat(&index, end: end, separator: 44)
                let y2 = try CGFloat.readCGFloat(&index, end: end, separator: 32)
                let x = try CGFloat.readCGFloat(&index, end: end, separator: 44)
                let y = try CGFloat.readCGFloat(&index, end: end, separator: 32)
                context.addCurve(to: CGPoint(x: x, y: y), control1: CGPoint(x: x1, y: y1), control2: CGPoint(x: x2, y: y2))
                
                //print("Line to \(x), \(y)")
                if strokeOnMove {
                    context.strokePath()
                    context.move(to: CGPoint(x: x, y: y))
                }
            } else if c == 90 { // Z
                if index != end && index.pointee != 32 {
                    throw CGFloat.ParsingError.Generic
                }
                
                //CGContextClosePath(context)
                context.fillPath()
                //CGContextBeginPath(context)
                //print("Close")
            } else if c == 83 { // S
                if index != end && index.pointee != 32 {
                    throw CGFloat.ParsingError.Generic
                }
                
                //CGContextClosePath(context)
                context.strokePath()
                //CGContextBeginPath(context)
                //print("Close")
            } else if c == 32 { // space
                continue
            } else {
                throw CGFloat.ParsingError.Generic
            }
        }
    }
    
    func tint(with color:UIColor, backgroundColor: UIColor? = nil, alpha:CGFloat = 1.0) -> UIImage?{
        let image = self
        let imageSize = image.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, backgroundColor != nil, image.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.setAlpha(alpha)
            
            if let backgroundColor = backgroundColor {
                context.setFillColor(backgroundColor.cgColor)
                context.fill(CGRect(origin: CGPoint(), size: imageSize))
            }
            
            let imageRect = CGRect(origin: CGPoint(), size: imageSize)
            context.saveGState()
            context.translateBy(x: imageRect.midX, y: imageRect.midY)
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: -imageRect.midX, y: -imageRect.midY)
            context.clip(to: imageRect, mask: image.cgImage!)
//            context.setFillColor(color.cgColor)
            context.setFillColor(red: color.rgb.r, green: color.rgb.g, blue: color.rgb.b, alpha: alpha)
            context.fill(imageRect)
            
            context.restoreGState()
        }
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
    
    class func generateTintedImage(image: UIImage?, color: UIColor, backgroundColor: UIColor? = nil) -> UIImage? {
        guard let image = image else {
            return nil
        }
        
        let imageSize = image.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, backgroundColor != nil, image.scale)
        if let context = UIGraphicsGetCurrentContext() {
            if let backgroundColor = backgroundColor {
                context.setFillColor(backgroundColor.cgColor)
                context.fill(CGRect(origin: CGPoint(), size: imageSize))
            }
            
            let imageRect = CGRect(origin: CGPoint(), size: imageSize)
            context.saveGState()
            context.translateBy(x: imageRect.midX, y: imageRect.midY)
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: -imageRect.midX, y: -imageRect.midY)
            context.clip(to: imageRect, mask: image.cgImage!)
            context.setFillColor(color.cgColor)
            context.fill(imageRect)
            context.restoreGState()
        }
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
    
    convenience init?(bundleImageName: String) {
        self.init(named: bundleImageName, in: frameworkBundle, compatibleWith: nil)
    }
    
    func makeCircularImage(size: CGSize) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect(origin: .zero, size: size)
        
        // begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        
        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)
        
        // clip to the circle
        circle.addClip()
        
        UIColor.white.set()
        circle.fill()
        
        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)
        
        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext()
        
        return roundedImage ?? self
    }
    
    func addOverlayColor( _ fillColor: UIColor = UIColor(white: 0, alpha: 0.5)) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: CGPoint.zero)
        let context = UIGraphicsGetCurrentContext()
        
        // set fill gray and alpha
        context?.setFillColor(fillColor.cgColor)
        //context!.setFillColor(gray: 0, alpha: 0.5)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.fill(CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        context?.strokePath()
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // end the graphics context
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    
    func resize(width: CGFloat) -> UIImage? {
        //let height:CGFloat = CGFloat(ceil(width/size.width * size.height))
        
        let scale = width / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: newHeight))
        self.draw(in: CGRect(x:0, y:0, width:width, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
        /*
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
 */
    }
    
    class func drawCircle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
}
