//
//  Locale+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 12/14/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension Locale {
    public var isPersianBasedLanguage: Bool{
        let m_languaceCode = self.languageCode
        if m_languaceCode == "ar" || m_languaceCode == "fa" {
            return true
        }
        return false
    }
}
