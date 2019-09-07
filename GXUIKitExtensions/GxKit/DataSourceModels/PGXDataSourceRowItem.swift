//
//  PGXDataSourceItem.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public class PGXDataSourceRowItem {
    public let type:GxDataSourceRowSectionOrderedIdType
    public let value:Any?
    init(value:Any?, type:GxDataSourceRowSectionOrderedIdType){
        self.value = value;
        self.type = type;
    }
}

internal extension Array where Iterator.Element == PGXDataSourceRowItem {
    func find(rowId:String) -> PGXDataSourceRowItem? {
        return self.first(where: { return $0.type.rowId == rowId } )
    }
    //[PGXDataSourceRowItem]
    
    func findFirstRowIndexToInsert(type: GxDataSourceRowSectionOrderedIdType) -> Int {
        var returnIndex:Int = 0;
        for (index, item) in self.enumerated() {
            //LOGD("index:\(index)  item:\(item.type.sectionId)  rowId:\(item.type.rowId)  rowOrder:\(item.type.rowOrder)  type.rowOrder:\(type.rowOrder)")
            if type.rowOrder >= item.type.rowOrder {
                returnIndex = index + 1;
            }
        }
        return returnIndex;
    }
}

