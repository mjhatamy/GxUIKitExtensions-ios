//
//  UIInterfaceOrientationMask+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 8/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension UIInterfaceOrientationMask {
    public func supports(_ orientation: UIInterfaceOrientation) -> Bool {
        return (orientation.isLandscape && self.contains(.landscape))
            || (orientation.isPortrait && self.contains(.portrait))
    }
    
    public func misses(_ orientation: UIInterfaceOrientation) -> Bool {
        return !supports(orientation)
    }
}
