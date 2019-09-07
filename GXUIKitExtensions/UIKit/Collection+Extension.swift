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

public extension Collection where Element == String {
    func pairs(step: Int, separator:String = "") -> [String] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/step + count % step
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: step, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex].joined(separator: separator)
        }
    }
    
    func joined( itemsPerPair:Int, pairsPerLine:Int, itemSeparator:String = "", lineSeparator:String = "" ) -> String {
        let list = self.pairs(step: itemsPerPair);
        var count:Int = 0;
        var outString = [String]();
        for item in list {
            count += 1;
            outString.append(item)
            if count >= pairsPerLine {
                outString.append(lineSeparator)
                count = 0;
            } else{
                outString.append(itemSeparator)
            }
        }
        return outString.joined();
    }
    
    
}
