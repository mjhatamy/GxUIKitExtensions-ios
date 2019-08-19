//
//  UIViewController+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/6/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

var global_safeAreaInsets:UIEdgeInsets = .zero

public extension UIViewController {
    
    static var safeAreaInsets:UIEdgeInsets{
        if Thread.isMainThread {
            if #available(iOS 11.0, *) {
                if let m_global_safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
                    global_safeAreaInsets = m_global_safeAreaInsets
                }
            }
        }else{
            DispatchQueue.main.async {
                if #available(iOS 11.0, *) {
                    if let m_global_safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets  {
                        global_safeAreaInsets = m_global_safeAreaInsets
                    }
                }
            }
        }
        return global_safeAreaInsets
    }
    
    //Show Dialog Boxes
    func ShowOkCancelAlertDialog(title:String?, message:String?, okButtonTitle:String, okButtonTextColor:UIColor?, cancelButtonTitle:String?, cancelButtonTextColor:UIColor?,  Completion:((_ Decision:Bool) -> Void)? ) -> Void {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: okButtonTitle, style: .destructive) { (action) in
            Completion?(true)
        }
        
        if okButtonTextColor != nil {
            okAction.setValue(okButtonTextColor, forKey: "titleTextColor")
        }
        
        alertController.addAction(okAction)
        
        if cancelButtonTitle != nil {
            let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel) { (action) in
                Completion?(false)
            }
            
            if cancelButtonTextColor != nil {
                cancelAction.setValue(cancelButtonTextColor, forKey: "titleTextColor")
            }
            
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true) {}
    }
}
