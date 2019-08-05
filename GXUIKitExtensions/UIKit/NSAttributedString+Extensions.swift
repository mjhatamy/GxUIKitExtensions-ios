//
//  NSAttributedString+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension NSAttributedString {
    public class func make(_ string:String, foregroundColor:UIColor, font:UIFont?, alignment:NSTextAlignment? = nil, backgroundColor:UIColor? = nil) -> NSAttributedString{
        var attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = foregroundColor
        
        if let m_font:UIFont = font {
            attributes[NSAttributedString.Key.font] = m_font
        }
        
        if let m_alignment:NSTextAlignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = m_alignment
            
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let m_backgroundColor = backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = m_backgroundColor
        }
        
        return NSAttributedString(string: string, attributes: attributes)
    }
}

extension NSMutableAttributedString {
    public class func make1(_ string:String, foregroundColor:UIColor, font:UIFont?, alignment:NSTextAlignment? = nil, backgroundColor:UIColor? = nil) -> NSMutableAttributedString{
        var attributes:[NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = foregroundColor
        
        if let m_font:UIFont = font {
            attributes[NSAttributedString.Key.font] = m_font
        }
        
        if let m_alignment:NSTextAlignment = alignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = m_alignment
            
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let m_backgroundColor = backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = m_backgroundColor
        }
        
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
}
