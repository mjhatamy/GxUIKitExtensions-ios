//
//  UINavigationController+Extensions.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 3/21/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

let navigationControllerLargeTitle = UINavigationController()
//navigationControllerLargeTitle.navigationBar.prefersLargeTitles = true

public struct UINavigationControllerDefaults {
    struct LargeTitle {
        
    }
    public struct Normal {
        public var bounds:CGRect = .zero
        public struct NavigationBar {
            public var bounds:CGRect = .zero
        }
        public var navigationBar:NavigationBar = NavigationBar()
    }
    public var normal = Normal()
}
var navigationControllerDefaults:UINavigationControllerDefaults = UINavigationControllerDefaults()

public extension UINavigationController {
    static var navigationController:UINavigationController?
    
    static var defaults:UINavigationControllerDefaults {
        
        if Thread.isMainThread {
            if navigationController == nil {
                navigationController =  UINavigationController.init()
            }
            navigationControllerDefaults.normal.bounds = navigationController?.view.bounds ?? .zero
            navigationControllerDefaults.normal.navigationBar.bounds = navigationController?.navigationBar.bounds ?? .zero
        }else{
            DispatchQueue.main.async {
                if navigationController == nil {
                    navigationController =  UINavigationController.init()
                }
                navigationControllerDefaults.normal.bounds = navigationController?.view.bounds ?? .zero
                navigationControllerDefaults.normal.navigationBar.bounds = navigationController?.navigationBar.bounds ?? .zero
            }
        }
        
        return navigationControllerDefaults
    }
}
