//
//  NSRegularExpression+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 4/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    public func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
