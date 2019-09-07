//
//  PGxDataSource.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

internal class PGxDataSourceSectionItem {
    var values:[PGXDataSourceRowItem] = [PGXDataSourceRowItem]();
    let sectionId:String
    /// Sections with order -1 will be appended at the end of the list and will not be inserted
    let sectionOrder:Int
    init(sectionId:String, sectionOrder:Int){
        self.sectionId = sectionId;
        self.sectionOrder = sectionOrder;
    }
}

internal extension Array where Iterator.Element == PGxDataSourceSectionItem {

    func first(sectionId:String) -> PGxDataSourceSectionItem? {
        return self.first(where: { return $0.sectionId == sectionId } )
    }
    
    func first(sectionId:String, rowId:String) -> PGXDataSourceRowItem? {
        return self.first(where: { return $0.sectionId == sectionId } )?.values.find(rowId: rowId)
    }
    
    func sectionOrder(sectionId:String) -> Int? {
        return self.first(where: { return $0.sectionId == sectionId } )?.sectionOrder
    }
    
    func sectionIndex(sectionId:String) -> Int? {
        return self.firstIndex(where: { return $0.sectionId == sectionId } )
    }
    
    func firstIndexPath(sectionId:String, rowId:String) -> IndexPath? {
        guard let section = self.sectionOrder(sectionId: sectionId) else {
            LOGE("Unable to find section index for item with sectionId:\(sectionId)")
            return nil
        }
        guard let row = self.first(where: { return $0.sectionId == sectionId } )?.values.firstIndex(where: { $0.type.rowId == rowId }) else {
            LOGE("Unable to find row index for item with sectionId:\(sectionId)  rowId:\(rowId)")
            return nil
        }
        return IndexPath(row: row, section: section);
    }
    
    func firstIndexPath(type: GxDataSourceRowSectionOrderedIdType) -> IndexPath? {
        return self.firstIndexPath(sectionId: type.sectionId, rowId: type.rowId)
    }
    
    func findFirstSectionIndexToInsert(_ type:GxDataSourceRowSectionOrderedIdType) -> Int {
        var newIndex:Int = 0
        for (index, item) in self.enumerated() {
            if type.sectionOrder > item.sectionOrder {
                newIndex = index + 1;
            }
        }
        return newIndex;
    }
    
    func getSection( section:Int ) -> PGxDataSourceSectionItem? {
        return self.first(where: { $0.sectionOrder == section });
    }
}
