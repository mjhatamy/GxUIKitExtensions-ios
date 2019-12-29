//
//  NSAttributedString+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension NSAttributedString {
    public func lastLineWidth( containerMaxWidth: CGFloat) -> CGFloat {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let labelSize = CGSize(width: containerMaxWidth, height: .infinity)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: labelSize)
        let textStorage = NSTextStorage(attributedString: self)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.maximumNumberOfLines = 0

        let lastGlyphIndex = layoutManager.glyphIndexForCharacter(at: self.length - 1)
        let lastLineFragmentRect = layoutManager.lineFragmentUsedRect(forGlyphAt: lastGlyphIndex,
                                                                      effectiveRange: nil)

        return lastLineFragmentRect.maxX
    }
    
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
