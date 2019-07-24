//
//  Data+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/28/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension Data{
    public var hexString:String{
        return self.map { String(format: "%02.2hhx", $0) }.joined()
    }
}

