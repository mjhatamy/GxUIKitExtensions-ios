//
//  UIApplication+Extension.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 12/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

extension UIApplication {
    public var activeWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    public var firstWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}
