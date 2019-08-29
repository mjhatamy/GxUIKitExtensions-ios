//
//  GxDataSource.swift
//  RxSwiftTest
//
//  Created by Majid Hatami Aghdam on 8/27/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import RxSwift

public struct GxTableSectionIdAndOrderModel: Equatable {
    public let order:Int
    public let id:String
    public init( id:String, order:Int ){
        self.id = id;
        self.order = order;
    }
}

extension Array where Iterator.Element == GxTableDataSourceModel {
    fileprivate func indexForSectionId(_ sectionId:String) -> Int? {
        let index = self.firstIndex { (items) -> Bool in
            return items.sectionOrder.id == sectionId;
        }
        return index;
    }
    
    fileprivate func findSectionForNewItemToInsert(_ compareSection:GxTableSectionIdAndOrderModel) -> Int {
        var newIndex:Int = 0
        for (index, item) in self.enumerated() {
            if compareSection.order > item.sectionOrder.order {
                newIndex = index + 1;
            }
        }
        return newIndex;
    }
}

extension Array where Iterator.Element == GxTableSectionIdAndOrderModel {
    fileprivate func find(_ sectionId:String) -> GxTableSectionIdAndOrderModel? {
        return self.first(where: { return $0.id == sectionId } )
    }
}

fileprivate class GxTableDataSourceModel{
    var values:[Any] = [Any]();
    let sectionOrder:GxTableSectionIdAndOrderModel
    init(_ sectionOrder:GxTableSectionIdAndOrderModel, initialItem:Any) {
        self.sectionOrder = sectionOrder
        self.values.append(initialItem)
    }
}

public struct GxDataSourceChangesSet {
    let insertions:[IndexPath]
    let deletions:[IndexPath]
    let modifications:[IndexPath]
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
    private var values:[GxTableDataSourceModel] = [GxTableDataSourceModel]();
    
    fileprivate var tableSectionOrderAndIds:[GxTableSectionIdAndOrderModel] = [GxTableSectionIdAndOrderModel]();
    
    /**
        Initialize GxTableDataSource using Section Order Names and order of the ids , defines their order in the Data Source or better call it , Section Id.
     - parameters:
        - tableSectionOrderedIds: Defines names for each section. Names must be string, and no duplicates. The order of the items in this array defines the order of the items
     */
    public init( sectionOrderedIds:[String] ) {
        assert(sectionOrderedIds.count > 0, "At least one section must be entered to initialize");
        pthread_mutex_init(&self.transactionMutexLock, nil)
        for (index, item) in sectionOrderedIds.enumerated() {
            self.tableSectionOrderAndIds.append(GxTableSectionIdAndOrderModel(id: item, order: index));
        }
    }
    
    public init( sectionOrderedIds:[GxTableSectionIdAndOrderModel] ) {
        assert(sectionOrderedIds.count > 0, "At least one section must be entered to initialize");
        pthread_mutex_init(&self.transactionMutexLock, nil)
        self.tableSectionOrderAndIds = sectionOrderedIds;
    }
    
    deinit {
        pthread_mutex_destroy(&self.transactionMutexLock)
    }
    
    public func getItem<T>(for indexPath:IndexPath) -> T? {
        if indexPath.section > self.values.count {
            LOGE("IndexPath.section:\(indexPath.section) out of bound")
            return nil
        }
        
        if indexPath.row > self.values[indexPath.section].values.count {
            LOGE("IndexPath.row:\(indexPath.row) out of bound for section:\(indexPath.section)")
            return nil
        }
        
        return self.values[indexPath.section].values[indexPath.section] as? T
    }
    
    public func getSectionId(for section:Int) -> String?{
        if section > self.values.count {
            LOGE("IndexPath.section:\(section) out of bound")
            return nil
        }
        return self.values[section].sectionOrder.id
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
        for item in transactionChangeSet {
            insertions.append(contentsOf: item.insertions)
            deletions.append(contentsOf: item.deletions)
            modifications.append(contentsOf: item.modifications)
        }
        self.changeSetSubject.onNext(GxDataSourceChangesSet(insertions: insertions, deletions: deletions, modifications: modifications))
    }
    
    public func append( _ item:Any, _ sectionId:String) throws {
        let changes = try self._append(item, sectionId)
        self.transactionChangeSet.append(changes)
    }
    
    public func remove( _ itemRowIndex:Int, _ sectionId:String ) throws {
        let changes = try self._remove(itemRowIndex, sectionId)
        self.transactionChangeSet.append(changes)
    }
    
    
    private func _append( _ item:Any, _ sectionId:String) throws -> GxDataSourceChangesSet {
        /// if this item already exist, append to the array and return, if no sectionIdAndOrders Entered, then 0
        guard let sectionIdAndOrder:GxTableSectionIdAndOrderModel = self.tableSectionOrderAndIds.find(sectionId) else {
            throw GxTableDataSourceError.AppendError(reason: "No section found for sectionId: \(sectionId) in tableSectionOrderAndIds")
        }
        
        if let sectionIndexForExisting:Int = self.values.indexForSectionId(sectionId) {
            self.values[sectionIndexForExisting].values.append(item)
            let rowIndex:Int = self.values[sectionIndexForExisting].values.count - 1;
            return GxDataSourceChangesSet(insertions: [IndexPath(row: rowIndex, section: sectionIndexForExisting)], deletions: [], modifications: []);
        }
        
        /// find first Item order and id
        let IndexToInsert = self.values.findSectionForNewItemToInsert(sectionIdAndOrder)
        
        /// Generate Move ChangeSet for Items after this Index
        let changeSet = self.makeChangeSetForInsertActionOn(section: IndexToInsert)
        
        self.values.insert(GxTableDataSourceModel(sectionIdAndOrder, initialItem: item), at: IndexToInsert)
        var insertions:[IndexPath] = [IndexPath]();
        insertions.append(IndexPath(row: 0, section: IndexToInsert))
        insertions.append(contentsOf: changeSet.insertions)
        
        return GxDataSourceChangesSet(insertions: insertions, deletions: changeSet.deletions, modifications: changeSet.modifications);
    }
    
    
    
    private func _remove( _ itemRowIndex:Int, _ sectionId:String ) throws -> GxDataSourceChangesSet {
        guard let sectionIndexForExisting:Int = self.values.indexForSectionId(sectionId) else {
            throw GxTableDataSourceError.NotFound(reason: "No Item found for sectionId: \(sectionId) in tableSectionOrderAndIds")
        }
        let itemValues = self.values[sectionIndexForExisting].values;
        
        if itemValues.count < itemRowIndex {
            throw GxTableDataSourceError.IndexOutOfBound(reason: "trying to Remove item for SectionId:\(sectionId) at sectionIndex:\(sectionIndexForExisting) at rowIndex:\(itemRowIndex) failed due to outof bound. available items count:\(itemValues.count)")
        }
        
        /// if section has more than 1 item, then only remove item at indexPath
        if itemValues.count > 1 {
            self.values[sectionIndexForExisting].values.remove(at: itemRowIndex)
            return GxDataSourceChangesSet(insertions: [], deletions: [IndexPath(row: itemRowIndex, section: sectionIndexForExisting)], modifications: []);
        }
        
        /// if item as only One Item and we are going to remove this only Item, then remove section as well
        var deletions:[IndexPath] = [IndexPath]() ;
        deletions.append(IndexPath(row: itemRowIndex, section: sectionIndexForExisting))
        
        let changeSet = self.makeChangeSetForRemoveActionOn(section: sectionIndexForExisting)
        deletions.append(contentsOf: changeSet.deletions)
        return GxDataSourceChangesSet(insertions: changeSet.insertions, deletions: deletions, modifications: changeSet.modifications);
    }
    
    private func makeChangeSetForRemoveActionOn(section sectionIndex:Int) -> GxDataSourceChangesSet {
        var deletions:[IndexPath] = [IndexPath]()
        var insertions:[IndexPath] = [IndexPath]()
        for (index, item) in self.values.enumerated() {
            if index > sectionIndex {
                for (itemIndex, _) in item.values.enumerated() {
                    deletions.append(IndexPath(row: itemIndex, section: index))
                    insertions.append(IndexPath(row: itemIndex, section: index - 1))
                }
            }
        }
        return GxDataSourceChangesSet(insertions: insertions, deletions: deletions, modifications: [])
    }
    
    private func makeChangeSetForInsertActionOn(section sectionIndex:Int) -> GxDataSourceChangesSet {
        var deletions:[IndexPath] = [IndexPath]()
        var insertions:[IndexPath] = [IndexPath]()
        for (index, item) in self.values.enumerated() {
            if index >= sectionIndex {
                for (itemIndex, _) in item.values.enumerated() {
                    deletions.append(IndexPath(row: itemIndex, section: index))
                    insertions.append(IndexPath(row: itemIndex, section: index + 1))
                }
            }
        }
        return GxDataSourceChangesSet(insertions: insertions, deletions: deletions, modifications: [])
    }
    
    public var numberOfSections:Int { return self.values.count }
    
}
