//
//  UIColor+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/6/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public struct UIColorRGB{
    let r:CGFloat
    let g:CGFloat
    let b:CGFloat
    let a:CGFloat
    
    var uintVal: UInt32 {
        return (UInt32(r * 255.0) << 16) | (UInt32(g * 255.0) << 8) | (UInt32(b * 255.0))
    }
}

public extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(red: CGFloat((rgb >> 16) & 0xff) / 255.0, green: CGFloat((rgb >> 8) & 0xff) / 255.0, blue: CGFloat(rgb & 0xff) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: UInt32, alpha: CGFloat) {
        self.init(red: CGFloat((rgb >> 16) & 0xff) / 255.0, green: CGFloat((rgb >> 8) & 0xff) / 255.0, blue: CGFloat(rgb & 0xff) / 255.0, alpha: alpha)
    }
    
    convenience init(argb: UInt32) {
        self.init(red: CGFloat((argb >> 16) & 0xff) / 255.0, green: CGFloat((argb >> 8) & 0xff) / 255.0, blue: CGFloat(argb & 0xff) / 255.0, alpha: CGFloat((argb >> 24) & 0xff) / 255.0)
    }
    
    convenience init?(hexString: String) {
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var num: UInt32 = 0
        if scanner.scanHexInt32(&num) {
            self.init(rgb: num)
        } else {
            return nil
        }
    }
    
    var alpha: CGFloat {
        var alpha: CGFloat = 0.0
        if self.getRed(nil, green: nil, blue: nil, alpha: &alpha) {
            return alpha
        } else if self.getWhite(nil, alpha: &alpha) {
            return alpha
        } else {
            return 0.0
        }
    }
    
    /*
    var rgb: UInt32 {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (UInt32(red * 255.0) << 16) | (UInt32(green * 255.0) << 8) | (UInt32(blue * 255.0))
    }
    */
    var rgb: UIColorRGB {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha:CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColorRGB(r: red, g: green, b: blue, a: alpha)
        //return (UInt32(red * 255.0) << 16) | (UInt32(green * 255.0) << 8) | (UInt32(blue * 255.0))
    }
    
    var argb: UInt32 {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (UInt32(alpha * 255.0) << 24) | (UInt32(red * 255.0) << 16) | (UInt32(green * 255.0) << 8) | (UInt32(blue * 255.0))
    }
    
    var hsv: (CGFloat, CGFloat, CGFloat) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var value: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &value, alpha: nil) {
            return (hue, saturation, value)
        } else {
            return (0.0, 0.0, 0.0)
        }
    }
    
    func withMultipliedBrightnessBy(_ factor: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return UIColor(hue: hue, saturation: saturation, brightness: max(0.0, min(1.0, brightness * factor)), alpha: alpha)
    }
    
    func mixedWith(_ other: UIColor, alpha: CGFloat) -> UIColor {
        let alpha = min(1.0, max(0.0, alpha))
        let oneMinusAlpha = 1.0 - alpha
        
        var r1: CGFloat = 0.0
        var r2: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a1: CGFloat = 0.0
        var a2: CGFloat = 0.0
        if self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) &&
            other.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        {
            let r = r1 * oneMinusAlpha + r2 * alpha
            let g = g1 * oneMinusAlpha + g2 * alpha
            let b = b1 * oneMinusAlpha + b2 * alpha
            let a = a1 * oneMinusAlpha + a2 * alpha
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
        return self
    }
    
    
    class var gixFlatColor:UIColor { return UIColor(rgb: 0x1D6FF2 ); }
    
    class var iosRed:UIColor { return UIColor.init(red: 1.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0); }
    class var iosOrange:UIColor { return UIColor.init(red: 1.0, green: 149.0/255.0, blue: 0, alpha: 1.0); }
    class var iosYellow:UIColor { return UIColor.init(red: 1.0, green: 204.0/255.0, blue: 0, alpha: 1.0); }
    class var iosGreen:UIColor { return UIColor.init(red: 0x4C/255.0, green: 0xD9/255.0, blue: 0x64/255.0, alpha: 1.0); }
    class var iosTealBlue:UIColor { return UIColor.init(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0); }
    class var iosBlue:UIColor { return UIColor.init(red: 0, green: 122.0/255.0, blue: 1.0, alpha: 1.0); }
    class var iosPurple:UIColor { return UIColor.init(red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1.0); }
    class var iosPink:UIColor { return UIColor.init(red: 1.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1.0); }
}
