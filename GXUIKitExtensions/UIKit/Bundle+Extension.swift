//
//  Bundle+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/28/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension Bundle {
    public var isProductionEnvironment: Bool{
        #if DEBUG
        return false
        #elseif ADHOC
        return false
        #else
        return true
        #endif
    }
}
