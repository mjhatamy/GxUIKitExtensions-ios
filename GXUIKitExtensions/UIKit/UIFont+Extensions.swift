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
        
        guard
            let bundle = Bundle(identifier: "com.mygix.GXUIKitExtensions"),
            let pathForResourceString = bundle.path(forResource: filenameString, ofType: fileExtension) else {
                LOGE("UIFont+:  Failed to register font - path for resource: \(filenameString).\(fileExtension) not found.")
            return false
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return false
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return false
        }
        
        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return false
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
            return false
        }else{
            return true
        }
    }
    
    class func SFProTextLightFont(_ size: CGFloat = 12) -> UIFont?{
        if !UIFont.SFProTextLightFont_IsRegistered { UIFont.SFProTextLightFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Light", fileExtension: "otf") }
        return UIFont.init(name: "SFProText-Light", size: size); }
    
    class func SFProTextRegularFont(_ size: CGFloat = 12) -> UIFont?{
        if !UIFont.SFProTextRegularFont_IsRegistered { UIFont.SFProTextRegularFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Regular", fileExtension: "otf") }
        return UIFont.init(name: "SFProText-Regular", size: size); }
    
    class func SFProTextSemiBoldFont(_ size: CGFloat = 12) -> UIFont?{
        if !UIFont.SFProTextSemiBoldFont_IsRegistered { UIFont.SFProTextSemiBoldFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Semibold", fileExtension: "otf") }
        return UIFont.init(name: "SFProText-Semibold", size: size); }
    
    class func SFProTextBoldFont(_ size: CGFloat = 12) -> UIFont?{
        if !UIFont.SFProTextBoldFont_IsRegistered { UIFont.SFProTextBoldFont_IsRegistered = UIFont.registerFontIfRequired(withFilenameString: "SF-Pro-Text-Bold", fileExtension: "otf") }
        return UIFont.init(name: "SFProText-bold", size: size); }
    
    class var footnoteBold2:UIFont    { return UIFont.SFProTextSemiBoldFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold3:UIFont    { return UIFont.SFProTextSemiBoldFont(12) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteSemiBold4:UIFont    { return UIFont.SFProTextSemiBoldFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold4:UIFont    { return UIFont.SFProTextBoldFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    
    class var footnoteSemiBold5:UIFont    { return UIFont.SFProTextSemiBoldFont(10) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold5:UIFont    { return UIFont.SFProTextBoldFont(10) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    
    class var body:UIFont {
        if let font:UIFont = UIFont.SFProTextRegularFont(17) { return font }
        LOGE("Unable to load font SFProTextRegularFont size: 17")
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)  }
    
    class var callout:UIFont {
        if let font:UIFont = UIFont.SFProTextRegularFont(16) { return font }
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout) }
    
    class var calloutBold:UIFont    { return UIFont.SFProTextSemiBoldFont(16) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout) }
    class var caption1:UIFont       { return UIFont.SFProTextRegularFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1) }
    class var caption2:UIFont       { return UIFont.SFProTextRegularFont(11) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2) }
    class var footnote:UIFont       { return UIFont.SFProTextRegularFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnote2:UIFont       { return UIFont.SFProTextRegularFont(14) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var footnoteBold:UIFont   { return UIFont.SFProTextSemiBoldFont(13) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote) }
    class var subhead:UIFont        { return UIFont.SFProTextRegularFont(15) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    class var subhead2:UIFont        { return UIFont.SFProTextRegularFont(16) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    class var subhead3:UIFont        { return UIFont.SFProTextRegularFont(17) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline) }
    class var headline:UIFont       { return UIFont.SFProTextSemiBoldFont(17) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    class var headline2:UIFont      { return UIFont.SFProTextSemiBoldFont(18) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    class var headline3:UIFont      { return UIFont.SFProTextSemiBoldFont(19) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline) }
    
    
    class var callKitTitleGroupCall:UIFont         { return UIFont.SFProTextRegularFont(24) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    class var callKitSubTitleGroupCall:UIFont         { return UIFont.SFProTextLightFont(24) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    
    class var title1:UIFont         { return UIFont.SFProTextRegularFont(28) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1) }
    class var title2:UIFont         { return UIFont.SFProTextRegularFont(22) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2) }
    class var title3:UIFont         { return UIFont.SFProTextRegularFont(20) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3) }
    class var title4:UIFont         { return UIFont.SFProTextRegularFont(19) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3) }
    class var largeTitle:UIFont     { if #available(iOS 11.0, *) {
        return UIFont.SFProTextRegularFont(34) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
    } else {
        return UIFont.SFProTextRegularFont(34) ?? UIFont.systemFont(ofSize: 34)
        } }
    class var largeTitle2:UIFont    { if #available(iOS 11.0, *) {
        return UIFont.SFProTextRegularFont(36) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
    } else {
        return UIFont.SFProTextRegularFont(36) ?? UIFont.systemFont(ofSize: 36)
        } }
    class var largeTitle3:UIFont    { if #available(iOS 11.0, *) {
        return UIFont.SFProTextRegularFont(38) ?? UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
    } else {
        return UIFont.SFProTextRegularFont(38) ?? UIFont.systemFont(ofSize: 38)
        } }
}
