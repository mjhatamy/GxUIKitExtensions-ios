//
//  Globals.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 3/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public let ALPHABET_CAPITAL_CHARACTER_ARRAY = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

public let ALPHABET_ARRAY_FOR_TABLE_INDEX_SECTIONS = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z", "#"]

public let DeviceColorSpace = CGColorSpaceCreateDeviceRGB()
public let ScreenDeviceScale = UIScreen.main.scale
public let UIScreenPixel = 1.0 / ScreenDeviceScale


public func LOGD(_ params:String="", function:NSString = #function,  file:NSString = #file, line:Int = #line){
    print("✅[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}

public func LOGI(_ params:String="", function:NSString = #function, file:NSString = #file, line:Int = #line){
    print("🔵[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}

public func LOGW(_ params:String="", file:NSString = #file, function:NSString = #function, line:Int = #line){
    print("⚠️[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}
public func LOGE(_ params:String?, file:NSString = #file, function:NSString = #function, line:Int = #line){
    print("⛔️[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params ?? "")");
}
