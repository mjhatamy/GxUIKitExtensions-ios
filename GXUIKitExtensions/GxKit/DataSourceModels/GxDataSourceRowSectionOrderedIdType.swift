//
//  GxDataSourceItemOrderAndIdType.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public class GxDataSourceRowSectionOrderedIdType: Equatable, Comparable, CustomStringConvertible {
    public let sectionOrder:Int
    public let sectionId:String
    public let rowId:String
    public let rowOrder:Int
    public init( sectionId:String, sectionOrder:Int, rowId:String? = nil, rowOrder:Int? = nil){
        assert(sectionId != rowId, "GxDataSourceRowSectionOrderedIdType failed. sectionId:\(sectionId) must not be equal rowId:\(rowId ?? "")");
        //assert( ((rowId != nil && rowOrder == nil) || (rowId == nil && rowOrder == nil) || (rowId != nil && rowOrder != nil)), "GxDataSourceRowSectionOrderedIdType failed. rowOrder must be null if rowId is null");
        self.sectionId = sectionId;
        self.sectionOrder = sectionOrder;
        self.rowId = rowId ?? sectionId;
        self.rowOrder = rowOrder ?? Int.max;
    }
    
    public var hasRowId:Bool { return self.rowId != self.sectionId; }
    
    public static func == (lhs: GxDataSourceRowSectionOrderedIdType, rhs: GxDataSourceRowSectionOrderedIdType) -> Bool {
      return lhs.sectionOrder == rhs.sectionOrder && lhs.sectionId == rhs.sectionId && lhs.rowId == rhs.rowId && lhs.rowOrder == rhs.rowOrder
    }
    /// CompareAble
    public static func < (lhs: GxDataSourceRowSectionOrderedIdType, rhs: GxDataSourceRowSectionOrderedIdType) -> Bool {
        return lhs.sectionOrder < rhs.sectionOrder
    }
    public var description: String {
        var result:[String] = [String]();
        
        result.append("<class:\(GxDataSourceRowSectionOrderedIdType.self) ")
        result.append(" sectionId:\(self.sectionId) sectionOrder:\(self.sectionOrder)")
        
        result.append(" rowId:\(rowId)");
        result.append(" rowOrder:\(rowOrder)");
        result.append(" >");
        return result.joined()
    }
}

internal extension Array where Iterator.Element == GxDataSourceRowSectionOrderedIdType {
    func find(sectionId:String) -> GxDataSourceRowSectionOrderedIdType? {
        return self.first(where: { return $0.sectionId == sectionId } )
    }
    
    func find(sectionId:String, rowId:String?) -> GxDataSourceRowSectionOrderedIdType? {
        return self.first(where: { return $0.sectionId == sectionId && $0.rowId == rowId } )
    }
    
    //fileprivate func find(_ section:GxDataSourceRowSectionOrderedIdType) -> GxDataSourceRowSectionOrderedIdType? {
    //    return self.first(where: { return ($0.sectionId == section.sectionId && $0.order == section.order && $0.rowId == section.rowId )})
    //}
    
    func uniqueSectionIds() -> [String] {
        var addDict = [String]();
        for item in self {
            if addDict.contains(where: { $0 ==  item.sectionId }) {
                continue;
            }
            addDict.append(item.sectionId)
        }
        return addDict;
    }
    
    func uniqueSectionIds() -> [GxDataSourceRowSectionOrderedIdType] {
        var addDict = [GxDataSourceRowSectionOrderedIdType]();
        for item in self {
            if addDict.contains(where: { $0.sectionId ==  item.sectionId }) {
                continue;
            }
            addDict.append(item)
        }
        return addDict;
    }
    
    func sortedUniqueSectionIds() -> [GxDataSourceRowSectionOrderedIdType] {
        let sectionIds:[GxDataSourceRowSectionOrderedIdType] = self.uniqueSectionIds();
        return sectionIds.sorted(by: { return ($0.sectionOrder < $1.sectionOrder) })
    }
    
    var numberOfSections:Int {
        let sectionIds:[String] = self.uniqueSectionIds();
        return sectionIds.count
    }
}
