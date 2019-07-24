//
//  Collection+Extension.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/8/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    /*!
     Safe method to return an object from an array. If index is out of bound, it will return nill
     */
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
