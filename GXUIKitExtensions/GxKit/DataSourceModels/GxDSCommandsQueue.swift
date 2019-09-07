//
//  GxDSCommandsQueue.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

internal class GxDSCommandInsertQueue {
    let type:GxDataSourceRowSectionOrderedIdType
    let value:Any?
    init(type:GxDataSourceRowSectionOrderedIdType, value:Any?) {
        self.type = type;
        self.value = value;
    }
}

internal class GxDSCommandInsertByIndexPathQueue: GxDSCommandInsertQueue {
    let indexPath:IndexPath
    init(indexPath:IndexPath, type:GxDataSourceRowSectionOrderedIdType, value:Any?) {
        self.indexPath = indexPath;
        super.init(type: type, value: value)
    }
}

internal class GxDSCommandsQueue {
    /// Section Id of the sections to be deleted
    var sectionsToDelete:[String] = [String]();
    /// Section Id of the sections to be inserted
    var sectionsToInsert:[String] = [String]();
    
    /// key == sectionId, value == row index.  this function must be processed in revered order grouped by sectionId order
    var sectionRowItemsToDelete:[String:[Int]] = [String:[Int]] ();
    
    var sectionRowItemsToInsertByIndexPath:[String:[GxDSCommandInsertByIndexPathQueue]] = [String:[GxDSCommandInsertByIndexPathQueue]] ();
    var sectionRowItemsToInsertByType:[String:[GxDSCommandInsertQueue]] = [String:[GxDSCommandInsertQueue]] ();
    
    func reset(types:[GxDataSourceRowSectionOrderedIdType]){
        self.sectionsToDelete.removeAll();
        self.sectionsToInsert.removeAll();
        
        self.sectionRowItemsToDelete.removeAll();
        self.sectionRowItemsToInsertByIndexPath.removeAll();
        self.sectionRowItemsToInsertByType.removeAll();
        
        for item in types.sortedUniqueSectionIds() {
            self.sectionRowItemsToDelete[item.sectionId] = [Int]()
            self.sectionRowItemsToInsertByIndexPath[item.sectionId] = [GxDSCommandInsertByIndexPathQueue]()
            self.sectionRowItemsToInsertByType[item.sectionId] = [GxDSCommandInsertQueue]()
        }
    }
}
