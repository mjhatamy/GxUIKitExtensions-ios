//
//  UIDevice+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 3/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public extension UIDevice {
    var uuidString:String{
        return UIDevice.current.identifierForVendor!.uuidString
    }
}

