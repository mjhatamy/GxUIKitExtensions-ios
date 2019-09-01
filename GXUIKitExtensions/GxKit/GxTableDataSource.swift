//
//  GxDataSource.swift
//  RxSwiftTest
//
//  Created by Majid Hatami Aghdam on 8/27/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import RxSwift

fileprivate struct GxTableRootItemOrderIdModel: Equatable, Comparable {
    fileprivate let order:Int
    fileprivate let rootId:String
    
    fileprivate init(order:Int, rootId:String) {
        self.order = order;
        self.rootId = rootId;
    }
    
    public static func == (lhs: GxTableRootItemOrderIdModel, rhs: GxTableRootItemOrderIdModel) -> Bool {
      return lhs.order == rhs.order && lhs.rootId == rhs.rootId
    }
    /// CompareAble
    public static func < (lhs: GxTableRootItemOrderIdModel, rhs: GxTableRootItemOrderIdModel) -> Bool {
        return lhs.order < rhs.order
    }
}

/**
 Order defines section for Main Section Types usually.
  When subId is available, then it will define an inner item. but there is no order for it.
    - parameters:
        - order: defines the order of the item in a section.
        - id: defines the Id of a section
        - subId: subId of the Item. if defined. items with SubId could may share same id
 */
public class GxTableItemOrderAndIdType: Equatable, Comparable, CustomStringConvertible {
    public let order:Int
    public let rootId:String
    public let itemId:String
    public init( rootId:String, order:Int, itemId:String? = nil ){
        self.rootId = rootId;
        self.order = order;
        self.itemId = itemId ?? rootId;
    }
    public var isRootElement:Bool {
        return self.rootId == self.itemId;
    }
    
    public static func == (lhs: GxTableItemOrderAndIdType, rhs: GxTableItemOrderAndIdType) -> Bool {
      return lhs.order == rhs.order && lhs.rootId == rhs.rootId && lhs.itemId == rhs.itemId
    }
    /// CompareAble
    public static func < (lhs: GxTableItemOrderAndIdType, rhs: GxTableItemOrderAndIdType) -> Bool {
        return lhs.order < rhs.order
    }
    public var description: String {
        return " <class:\(GxTableItemOrderAndIdType.self) order:\(self.order) rootId:\(self.rootId) itemId:\(self.itemId)>"
    }
}

extension Array where Iterator.Element == GxTableDataSourceRootItemModel {
    fileprivate func indexForSectionId(_ sectionId:String) -> Int? {
        let index = self.firstIndex { (items) -> Bool in
            return items.sectionOrder.rootId == sectionId;
        }
        return index;
    }
    
    fileprivate func sectionFor(rootId:String) -> Int?{
        let index = self.firstIndex { (items) -> Bool in
            return items.sectionOrder.rootId == rootId;
        }
        return index;
    }
    
    fileprivate func indexPathFor( type:GxTableItemOrderAndIdType) -> IndexPath? {
        guard let section = self.sectionFor(rootId: type.rootId) else {
            return nil
        }
        guard let row = self[section].values.firstIndex(where: { $0.type.itemId == type.itemId}) else{
            return nil
        }
        return IndexPath(row: row, section: section)
    }
    
    fileprivate func rootItemAt(section:Int) -> GxTableDataSourceRootItemModel? {
        return self[safe: section]
    }
    
    fileprivate func valuesAt(section:Int) -> [GxDataSourceItemModel]? {
        return self.rootItemAt(section: section)?.values
    }
    
    fileprivate func itemAt(indexPath:IndexPath) -> GxDataSourceItemModel? {
        return self[safe: indexPath.section]?.values[safe: indexPath.row]
    }
    
    /// If successfull, it will return removed element or null if nothing removed
    fileprivate func removeItemAt(indexPath:IndexPath) -> GxDataSourceItemModel? {
        return self.rootItemAt(section: indexPath.section)?.values.remove(at: indexPath.row)
    }
    
    fileprivate func typeAt(indexPath:IndexPath) -> GxTableItemOrderAndIdType?{
        return self.itemAt(indexPath: indexPath)?.type
    }
    
    fileprivate func findSectionForNewItemToInsert(_ compareSection:GxTableItemOrderAndIdType) -> Int {
        var newIndex:Int = 0
        for (index, item) in self.enumerated() {
            if compareSection.order > item.sectionOrder.order {
                newIndex = index + 1;
            }
        }
        return newIndex;
    }
}

extension Array where Iterator.Element == GxTableItemOrderAndIdType {
    fileprivate func find(_ sectionId:String) -> GxTableItemOrderAndIdType? {
        return self.first(where: { return $0.rootId == sectionId } )
    }
    
    fileprivate func find(_ section:GxTableItemOrderAndIdType) -> GxTableItemOrderAndIdType? {
        return self.first(where: { return ($0.rootId == section.rootId && $0.order == section.order && $0.itemId == section.itemId )})
    }
}

extension Array where Iterator.Element == GxDataSourceItemModel {
    fileprivate func indexFor(itemId:String) -> Int? {
        return self.firstIndex(where: { $0.type.itemId == itemId });
    }
}


public class GxDataSourceItemModel {
    public let type:GxTableItemOrderAndIdType
    public let value:Any
    init(value:Any, type:GxTableItemOrderAndIdType) {
        self.value = value;
        self.type = type;
    }
}

fileprivate class GxTableDataSourceRootItemModel{
    var values:[GxDataSourceItemModel] = [GxDataSourceItemModel]();
    let sectionOrder:GxTableRootItemOrderIdModel
    init(_ sectionOrder:GxTableRootItemOrderIdModel, initialItem:GxDataSourceItemModel) {
        self.sectionOrder = sectionOrder
        self.values.append(initialItem)
    }
}

public struct GxMoveIndexPath {
    public let from:IndexPath
    public let to:IndexPath
}

public struct GxDataSourceChangesSet {
    public let insertions:[IndexPath]
    public let deletions:[IndexPath]
    public let modifications:[IndexPath]
    public let moved:[GxMoveIndexPath]
    public let insertedSections:IndexSet
    public let deletedSections:IndexSet
}

public enum GxTableDataSourceError:Error {
    case AppendError(reason:String)
    case NotFound(reason:String)
    case IndexOutOfBound(reason:String)
    case NotInTransaction(reason:String)
}

public class GxTableDataSource {
    private var changeSetSubject:PublishSubject<GxDataSourceChangesSet> = PublishSubject<GxDataSourceChangesSet>();
    public var changesObservable:Observable<GxDataSourceChangesSet> {
        return changeSetSubject.asObserver()
    }
    /// SectionId: Int , Values: Array
    private var values:[GxTableDataSourceRootItemModel] = [GxTableDataSourceRootItemModel]();
    fileprivate var tableSectionOrderAndIds:[GxTableItemOrderAndIdType] = [GxTableItemOrderAndIdType]();
    
    /**
        Initialize GxTableDataSource using Section Order Names and order of the ids , defines their order in the Data Source or better call it , Section Id.
     - parameters:
        - tableSectionOrderedIds: Defines names for each section. Names must be string, and no duplicates. The order of the items in this array defines the order of the items
     */
    public init( sectionOrderedIds:[String] ) {
        assert(sectionOrderedIds.count > 0, "At least one section must be entered to initialize");
        pthread_mutex_init(&self.transactionMutexLock, nil)
        for (index, item) in sectionOrderedIds.enumerated() {
            self.tableSectionOrderAndIds.append(GxTableItemOrderAndIdType(rootId: item, order: index));
        }
    }
    
    public init( sectionOrderedIds:[GxTableItemOrderAndIdType] ) {
        assert(sectionOrderedIds.count > 0, "At least one section must be entered to initialize");
        pthread_mutex_init(&self.transactionMutexLock, nil)
        self.tableSectionOrderAndIds = sectionOrderedIds;
    }
    
    deinit {
        self.values.removeAll()
        pthread_mutex_destroy(&self.transactionMutexLock)
    }
    
    public func getItem(for indexPath:IndexPath) -> GxDataSourceItemModel? {
        if indexPath.section > self.values.count {
            LOGE("IndexPath.section:\(indexPath.section) out of bound")
            return nil
        }
        if indexPath.row > self.values[indexPath.section].values.count {
            LOGE("IndexPath.row:\(indexPath.row) out of bound for section:\(indexPath.section)")
            return nil
        }
        return self.values[indexPath.section].values[indexPath.row]
    }
    
    public func getSectionId(for section:Int) -> String?{
        if section > self.values.count {
            LOGE("IndexPath.section:\(section) out of bound")
            return nil
        }
        return self.values[section].sectionOrder.rootId
    }
    
    
    private var transactionMutexLock:pthread_mutex_t = pthread_mutex_t()
    private var transactionChangeSet:[GxDataSourceChangesSet] = [GxDataSourceChangesSet]();
    private var isInTransaction:Bool = false;
    public func transaction(_ f: () throws ->Void ) throws {
        do {
            pthread_mutex_lock(&self.transactionMutexLock)
            self.isInTransaction = true;
            self.transactionChangeSet.removeAll()
            /// Start Transaction
            try f();
            /// end transaction
            self.isInTransaction = false;
            pthread_mutex_unlock(&self.transactionMutexLock)
        } catch {
            self.isInTransaction = false;
            pthread_mutex_unlock(&self.transactionMutexLock)
            throw error;
        }
        var insertions = [IndexPath] ()
        var deletions = [IndexPath]()
        var modifications = [IndexPath]()
        var moved = [GxMoveIndexPath]();
        let insertedSections:NSMutableIndexSet = NSMutableIndexSet()
        let deletedSections:NSMutableIndexSet = NSMutableIndexSet();
        for item in self.transactionChangeSet {
            insertions.append(contentsOf: item.insertions)
            deletions.append(contentsOf: item.deletions)
            modifications.append(contentsOf: item.modifications)
            moved.append(contentsOf: item.moved)
            insertedSections.add(item.insertedSections)
            deletedSections.add(item.deletedSections)
        }
        self.changeSetSubject.onNext(GxDataSourceChangesSet(insertions: insertions, deletions: deletions, modifications: modifications, moved: moved, insertedSections: insertedSections as IndexSet, deletedSections: deletedSections as IndexSet))
        self.transactionChangeSet.removeAll()
    }
    
    public func append( _ item:Any, _ sectionId:GxTableItemOrderAndIdType) throws {
        let changes = try self._append(item, sectionId)
        self.transactionChangeSet.append(changes)
    }
    
    @discardableResult
    public func remove( _ indexPath:IndexPath, deleteSection:Bool = false) throws -> Bool {
        guard let changes = try self._remove(indexPath, deleteSection:deleteSection) else{
            return false
        }
        self.transactionChangeSet.append(changes)
        return true;
    }
    
    public func remove( _ type:GxTableItemOrderAndIdType , deleteSection:Bool = false) throws -> Bool {
        guard let indexPath:IndexPath = self.values.indexPathFor(type: type) else {
            LOGE("No Item found for Item of type:\(type)");
            return false;
        }
        return try self.remove(indexPath, deleteSection: deleteSection);
    }
    
    
    private func _append( _ item:Any, _ sectionId:GxTableItemOrderAndIdType) throws -> GxDataSourceChangesSet {
        /// if this item already exist, append to the array and return, if no sectionIdAndOrders Entered, then 0
        guard let sectionIdAndOrder:GxTableItemOrderAndIdType = self.tableSectionOrderAndIds.find(sectionId) else {
            throw GxTableDataSourceError.AppendError(reason: "No section found for sectionId: \(sectionId) subId:\(sectionId.itemId) in tableSectionOrderAndIds")
        }
        
        if let sectionIndexForExisting:Int = self.values.sectionFor(rootId: sectionId.rootId) {
            self.values[sectionIndexForExisting].values.append(GxDataSourceItemModel(value: item, type: sectionId))
            let rowIndex:Int = self.values[sectionIndexForExisting].values.count - 1;
            return GxDataSourceChangesSet(insertions: [IndexPath(row: rowIndex, section: sectionIndexForExisting)], deletions: [], modifications: [], moved: [], insertedSections: [], deletedSections: []);
        }
        
        /// find first Item order and id
        let IndexToInsert = self.values.findSectionForNewItemToInsert(sectionIdAndOrder)
        
        /// Generate Move ChangeSet for Items after this Index
        let changeSet = self.onSectionInsert(section: IndexToInsert)
        
        self.values.insert(GxTableDataSourceRootItemModel(GxTableRootItemOrderIdModel(order: sectionId.order, rootId: sectionId.rootId), initialItem: GxDataSourceItemModel(value: item, type: sectionId)), at: IndexToInsert)
        var insertions:[IndexPath] = [IndexPath]();
        insertions.append(IndexPath(row: 0, section: IndexToInsert))
        insertions.append(contentsOf: changeSet.insertions)
        
        ///var deletions:[IndexPath] = [IndexPath]();
        
        return GxDataSourceChangesSet(insertions: insertions, deletions: changeSet.deletions, modifications: changeSet.modifications, moved: changeSet.moved, insertedSections: changeSet.insertedSections, deletedSections: changeSet.deletedSections);
    }
    
    private func _remove( _ indexPath:IndexPath, deleteSection:Bool = false ) throws -> GxDataSourceChangesSet? {
        var deleteSection:Bool = deleteSection;
        if self.values.count < indexPath.section {
            LOGE("Unable to remove Item at indexPath:\(indexPath). section out of bounds. maximum sections:\(self.values.count)");
            return nil
        }
        guard let _ = self.values.itemAt(indexPath: indexPath) else {
            LOGE("Unable to remove item at indexPath:\(indexPath). Item not found.");
            return nil
        }
        
        /// if only one item is remained in the section, and deleteSection is false, set it to true
        if !deleteSection { deleteSection = (self.values.rootItemAt(section: indexPath.section)?.values.count ?? 0) <= 1 }
        
        if deleteSection {
            /// if item as only One Item and we are going to remove this only Item, then remove section as well
            var deletions:[IndexPath] = [IndexPath]() ;
            for (index, _) in (self.values[safe: indexPath.section]?.values ?? []).enumerated() {
                deletions.append(IndexPath(row: index, section: indexPath.section))
            }
            self.values[safe:indexPath.section]?.values.removeAll();
            
            let changeSet = self.onSectionRemoved(section: indexPath.section)
            deletions.append(contentsOf: changeSet.deletions)
            
            self.values.remove(at: indexPath.section)
            
            return GxDataSourceChangesSet(insertions: changeSet.insertions, deletions: deletions, modifications: changeSet.modifications, moved: changeSet.moved, insertedSections: changeSet.insertedSections, deletedSections: changeSet.deletedSections);
        } else{
            let item = self.values.removeItemAt(indexPath: indexPath)
            return GxDataSourceChangesSet(insertions: [], deletions: (item != nil) ? [indexPath] : [], modifications: [], moved: [], insertedSections: [], deletedSections: []);
        }
    }
    
    private func onSectionRemoved(section sectionIndex:Int) -> GxDataSourceChangesSet {
        var moved = [GxMoveIndexPath]();
        let insertedSections:IndexSet = []
        let deletedSections:IndexSet = [sectionIndex]
        for (index, item) in self.values.enumerated() {
            if index > sectionIndex {
                for (itemIndex, _) in item.values.enumerated() {
                    moved.append(GxMoveIndexPath(from: IndexPath(row: itemIndex, section: index), to: IndexPath(row: itemIndex, section: index - 1)))
                }
            }
        }
        return GxDataSourceChangesSet(insertions: [], deletions: [], modifications: [], moved: moved, insertedSections: insertedSections, deletedSections: deletedSections)
    }
    
    private func onSectionInsert(section sectionIndex:Int) -> GxDataSourceChangesSet {
        var moved = [GxMoveIndexPath]();
        let insertedSections:IndexSet = [sectionIndex]
        let deletedSections:IndexSet = []
        for (index, item) in self.values.enumerated() {
            if index >= sectionIndex {
                for (itemIndex, _) in item.values.enumerated() {
                    moved.append(GxMoveIndexPath(from: IndexPath(row: itemIndex, section: index), to: IndexPath(row: itemIndex, section: index + 1)))
                }
            }
        }
        return GxDataSourceChangesSet(insertions: [], deletions: [], modifications: [], moved: moved, insertedSections: insertedSections, deletedSections: deletedSections)
    }
    
    public var numberOfSections:Int { return self.values.count }
    public func numberOfRowsInSection(_ section:Int ) -> Int {
        guard let count = self.values[safe: section]?.values.count else {
            LOGE("Section: \(section) not found.");
            return 0
        }
        return count
    }
    
}
