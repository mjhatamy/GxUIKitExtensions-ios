//
//  UIFont+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/6/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public extension UIFont {
    static private(set) var SFProTextLightFont_IsRegistered:Bool = false
    static private(set) var SFProTextRegularFont_IsRegistered:Bool = false
    static private(set) var SFProTextSemiBoldFont_IsRegistered:Bool = false
    static private(set) var SFProTextBoldFont_IsRegistered:Bool = false
    
    internal static func registerFontIfRequired(withFilenameString filenameString: String, fileExtension:String) -> Bool {
        let bundle = Bundle(for: GXUIKitExtensions.self)
        
        guard
             //Bundle(identifier: "com.mygix.GXUIKitExtensions"),
            let pathForResourceString = bundle.path(forResource: filenameString, ofType: fileExtension) else {
                LOGE("UIFont+:  Failed to register font - path for resource: \(filenameString).\(fileExtension) not found.")
            return false
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            LOGE("UIFont+:  Failed to register font - font data could not be loaded.")
            return false
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            LOGE("UIFont+:  Failed to register font - data provider could not be loaded.")
            return false
        }
        
        guard let font = CGFont(dataProvider) else {
            LOGE("UIFont+:  Failed to register font - font could not be loaded.")
            return false
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            LOGE("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
            errorRef?.release()
            return false
        }else{
            return true
        }
    }

    class func SFProTextLightFont(_ size: CGFloat = 12) -> UIFont?{
        guard let font = UIFont.init(name: "SFProText-Light", size: size) else{
            if !UIFont.SFProTextLightFont_IsRegistered { UIFont.SFProTextLightFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Light", fileExtension: "otf") }
            return UIFont.init(name: "SFProText-Light", size: size);
        }
        return font }
    
    class func SFProTextRegularFont(_ size: CGFloat = 12) -> UIFont?{
        guard let font = UIFont.init(name: "SFProText-Regular", size: size) else{
            if !UIFont.SFProTextRegularFont_IsRegistered { UIFont.SFProTextRegularFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Regular", fileExtension: "otf") }
            return UIFont.init(name: "SFProText-Regular", size: size);
        }
        return font
    }
    
    class func SFProTextSemiBoldFont(_ size: CGFloat = 12) -> UIFont?{
        guard let font = UIFont.init(name: "SFProText-Semibold", size: size) else{
            if !UIFont.SFProTextSemiBoldFont_IsRegistered { UIFont.SFProTextSemiBoldFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Semibold", fileExtension: "otf") }
            return UIFont.init(name: "SFProText-Semibold", size: size);
        }
        return font }
    
    class func SFProTextBoldFont(_ size: CGFloat = 12) -> UIFont?{
        guard let font = UIFont.init(name: "SFProText-bold", size: size) else{
            if !UIFont.SFProTextBoldFont_IsRegistered { UIFont.SFProTextBoldFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Bold", fileExtension: "otf") }
            return UIFont.init(name: "SFProText-bold", size: size);
        }
        return font;
    }
    
    class var footnoteBold2:UIFont    { return UIFont.SFProTextSemiBoldFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold3:UIFont    { return UIFont.SFProTextSemiBoldFont(12) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteSemiBold4:UIFont    { return UIFont.SFProTextSemiBoldFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold4:UIFont    { return UIFont.SFProTextBoldFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    
    class var footnoteSemiBold5:UIFont    { return UIFont.SFProTextSemiBoldFont(10) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold5:UIFont    { return UIFont.SFProTextBoldFont(10) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    
    
    private class func initCustom( _ textStyle:UIFont.TextStyle, weight:UIFont.Weight, design:UIFontDescriptor.SystemDesign = .default) -> UIFont{
        guard let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
            .addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: weight]])
            .withDesign(design) else {
                return UIFont.preferredFont(forTextStyle: textStyle)
        }
        return UIFont.init(descriptor: descriptor, size: 0)
    }
    
    class var body:UIFont { return UIFont.initCustom(UIFont.TextStyle.body, weight: UIFont.Weight.regular, design: UIFontDescriptor.SystemDesign.default)  }
    class var bodySemiBold:UIFont{ return UIFont.initCustom(UIFont.TextStyle.body, weight: UIFont.Weight.semibold, design: UIFontDescriptor.SystemDesign.default) }
    class var bodyLight:UIFont{ return UIFont.initCustom(UIFont.TextStyle.body, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.default) }
    class var bodyLightMono:UIFont{ return UIFont.initCustom(UIFont.TextStyle.footnote, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.monospaced) }
    
    
    class var callout:UIFont { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout) }
    class var calloutLight:UIFont { return UIFont.initCustom(UIFont.TextStyle.callout, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.default) }
    class var calloutSemiBold:UIFont { return UIFont.initCustom(UIFont.TextStyle.callout, weight: UIFont.Weight.semibold, design: UIFontDescriptor.SystemDesign.default) }
    class var calloutMono:UIFont { return UIFont.initCustom(UIFont.TextStyle.callout, weight: UIFont.Weight.regular, design: UIFontDescriptor.SystemDesign.monospaced) }
    
    //class var calloutLight:UIFont    { return UIFont.SFProTextLightFont(16) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout) }
    //class var calloutBold:UIFont    { return UIFont.SFProTextSemiBoldFont(16) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout) }
    class var caption1:UIFont       { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1) }
    //class var caption1Light:UIFont       { return UIFont.SFProTextLightFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1) }
    class var caption2:UIFont       { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2) }
    
    class var footnote:UIFont       { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    //class var footnoteLight:UIFont       { return UIFont.SFProTextLightFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    //class var footnote2:UIFont       { return UIFont.SFProTextRegularFont(14) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    //class var footnoteBold:UIFont   { return UIFont.SFProTextSemiBoldFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    
    class var subheadline:UIFont        { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    //class var subheadSemiBold:UIFont        { return UIFont.SFProTextSemiBoldFont(15) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    //class var subhead2:UIFont        { return UIFont.SFProTextRegularFont(16) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
   // class var subheadLight:UIFont        { return UIFont.SFProTextLightFont(15) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    //class var subhead3:UIFont        { return UIFont.SFProTextRegularFont(17) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    
    class var headline:UIFont       { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    //class var headline2:UIFont      { return UIFont.SFProTextSemiBoldFont(18) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    //class var headline3:UIFont      { return UIFont.SFProTextSemiBoldFont(19) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    
    
    class var callKitTitleGroupCall:UIFont         { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    class var callKitSubTitleGroupCall:UIFont         { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    
    
    class var title1:UIFont         { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    class var title1Mono:UIFont { return UIFont.initCustom(UIFont.TextStyle.title1, weight: UIFont.Weight.medium, design: UIFontDescriptor.SystemDesign.monospaced) }
    class var title1SemiBold:UIFont { return UIFont.initCustom(UIFont.TextStyle.title1, weight: UIFont.Weight.semibold, design: UIFontDescriptor.SystemDesign.default) }
    class var title1Light:UIFont { return UIFont.initCustom(UIFont.TextStyle.title1, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.default) }
    class var title1LightMono:UIFont { return UIFont.initCustom(UIFont.TextStyle.title1, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.monospaced) }
    
    
    class var title2:UIFont         { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2) }
    class var title2Mono:UIFont { return UIFont.initCustom(UIFont.TextStyle.title2, weight: UIFont.Weight.medium, design: UIFontDescriptor.SystemDesign.monospaced) }
    class var title2LightMono:UIFont { return UIFont.initCustom(UIFont.TextStyle.title2, weight: UIFont.Weight.light, design: UIFontDescriptor.SystemDesign.monospaced) }
    
    
    //class var title2Light:UIFont         { return UIFont.SFProTextLightFont(22) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2) }
    class var title3:UIFont         { return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3) }
    //class var title3Light:UIFont         { return UIFont.SFProTextLightFont(20) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3) }
    //class var title4:UIFont         { return UIFont.SFProTextRegularFont(19) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3) }
    
    class var largeTitle:UIFont     { if #available(iOS 11.0, *) {
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
    } else {
        return UIFont.SFProTextRegularFont(34) ?? UIFont.systemFont(ofSize: 34)
        } }
}
