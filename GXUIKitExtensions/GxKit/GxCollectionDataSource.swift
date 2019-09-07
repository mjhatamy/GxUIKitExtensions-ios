//
//  GxCollectionDataSource.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import RxSwift


public enum GxCollectionDataSourceError:Error {
    case AppendError(reason:String)
    case NotFound(reason:String)
    case IndexOutOfBound(reason:String)
    case NotInTransaction(reason:String)
}

public class GxCollectionDataSource {
    private var changeSetSubject:PublishSubject<GxDataChangeSet> = PublishSubject<GxDataChangeSet>();
    public var changesObservable:Observable<GxDataChangeSet> {
        return changeSetSubject.asObserver()
    }
    
    private var transactionMutexLock:pthread_mutex_t = pthread_mutex_t()
    private var isInTransaction:Bool = false;
    
    public let numberOfSections:Int
    fileprivate var commandsQueue:GxDSCommandsQueue = GxDSCommandsQueue()
    fileprivate var sectionsArray:[PGxDataSourceSectionItem] = [PGxDataSourceSectionItem]();
    fileprivate var tableRowSectionOrderAndIds:[GxDataSourceRowSectionOrderedIdType] = [GxDataSourceRowSectionOrderedIdType]();
    
    public init( tableRowSectionOrderAndIds:[GxDataSourceRowSectionOrderedIdType] ) {
        assert(tableRowSectionOrderAndIds.count > 0, "At least one section must be entered to initialize");
        pthread_mutex_init(&self.transactionMutexLock, nil)
        self.tableRowSectionOrderAndIds = tableRowSectionOrderAndIds;
        for type:GxDataSourceRowSectionOrderedIdType in tableRowSectionOrderAndIds.uniqueSectionIds() {
            self.sectionsArray.append(PGxDataSourceSectionItem(sectionId: type.sectionId, sectionOrder: type.sectionOrder))
        }
        self.numberOfSections = tableRowSectionOrderAndIds.numberOfSections
    }
    
    deinit {
        pthread_mutex_destroy(&self.transactionMutexLock)
    }
    
    public func transaction(_ f:@escaping () throws -> Void,  completion:@escaping (_ completed:Bool, _ error:Error?)->Void ) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                completion(false, nil)
                return }
            do {
                pthread_mutex_lock(&strongSelf.transactionMutexLock)
                strongSelf.isInTransaction = true;
                strongSelf.commandsQueue.reset(types: strongSelf.tableRowSectionOrderAndIds);
                
                 /// Start Transaction
                try f();
                /// end transaction
                
                try strongSelf.processTransaction()
                strongSelf.isInTransaction = false;
                pthread_mutex_unlock(&strongSelf.transactionMutexLock)
                completion(true, nil)
            } catch {
                strongSelf.isInTransaction = false;
                pthread_mutex_unlock(&strongSelf.transactionMutexLock)
                completion(true, error)
            }
        }
    }
    
    /*
    public func transaction(_ f: () throws -> Void ) throws {
        do {
            pthread_mutex_lock(&self.transactionMutexLock)
            self.isInTransaction = true;
            self.commandsQueue.reset(types: self.tableRowSectionOrderAndIds);
            
             /// Start Transaction
            try! f();
            /// end transaction
            
            try self.processTransaction()
            self.isInTransaction = false;
            pthread_mutex_unlock(&self.transactionMutexLock)
        } catch {
            self.isInTransaction = false;
            pthread_mutex_unlock(&self.transactionMutexLock)
            throw error;
        }
    }
    */
    
    private func processTransaction() throws {
        let nextChangeSet:GxDataChangeSet = GxDataChangeSet();
        
        /// Sort by SectionId orders
        for type in self.tableRowSectionOrderAndIds.sortedUniqueSectionIds().reversed() {
            if self.commandsQueue.sectionsToDelete.contains(type.sectionId), let sectionIndex:Int = self.sectionsArray.sectionOrder(sectionId: type.sectionId) {
                if let sectionValues = self.sectionsArray.first(sectionId: type.sectionId)?.values {
                    for (index, _ ) in sectionValues.enumerated().reversed() {
                        nextChangeSet.deletions.append(IndexPath(row: index, section: sectionIndex))
                    }
                    self.sectionsArray.first(sectionId: type.sectionId)?.values.removeAll()
                }
            }
        }
        
        for type in self.tableRowSectionOrderAndIds.sortedUniqueSectionIds() {
            //let sectionIndex:Int = self.sectionsArray.findFirstSectionIndexToInsert(type);
            /// section items sorted by rowOrder from low to high
            if let sectionItems:[GxDSCommandInsertQueue] = self.commandsQueue.sectionRowItemsToInsertByType[type.sectionId]?.sorted(by: { return ($0.type.rowOrder ) < ($1.type.rowOrder) }) {
                if sectionItems.count <= 0 { continue; }
                
                let sectionIndex:Int = self.sectionsArray.sectionIndex(sectionId: type.sectionId) ?? -1
                assert(sectionIndex > -1 , "sectionIndex:\(sectionIndex) must be greated or equal 0 for sectionId:\(type.sectionId)")
                assert(self.sectionsArray[safe: sectionIndex] != nil, "Section item must not be nil after insert at index:\(sectionIndex) for sectionId:\(type.sectionId)")
                
                for rowItem:GxDSCommandInsertQueue in sectionItems {
                    /// find row index to insert
                    if let rowIndex = self.sectionsArray[safe: sectionIndex]?.values.findFirstRowIndexToInsert(type: rowItem.type) {
                        self.sectionsArray.first(sectionId: rowItem.type.sectionId)?.values.insert(PGXDataSourceRowItem(value: rowItem.value, type: rowItem.type), at: rowIndex)
                        nextChangeSet.insertions.append(IndexPath(row: rowIndex, section: rowItem.type.sectionOrder))
                        //LOGD("sectionIndex: \(sectionIndex)  rowIndex: \(rowIndex)  noOfItem:\(self.sectionsArray[safe: sectionIndex]?.values.count ?? 0) type: \(rowItem.type)")
                    }
                }
            }
        }
        //LOGD("nextChangeSet\ninsertions:\(nextChangeSet.insertions)\ndeletions:\(nextChangeSet.deletions)\ninsertedSections:\(nextChangeSet.insertedSections)")
        if nextChangeSet.insertions.count > 0 || nextChangeSet.deletions.count > 0 {
            self.changeSetSubject.onNext(nextChangeSet)
        }
    }
    
    public func insert(row type:GxDataSourceRowSectionOrderedIdType, indexPath:IndexPath, value:Any ) throws {
        guard self.isInTransaction else { throw GxCollectionDataSourceError.NotInTransaction(reason: "Cannot call remove function while not in a transaction.") }
        self.commandsQueue.sectionRowItemsToInsertByIndexPath[type.sectionId]?.append(GxDSCommandInsertByIndexPathQueue(indexPath: indexPath, type: type, value: value))
    }
    
    public func append(row type:GxDataSourceRowSectionOrderedIdType, _ value:Any ) throws {
        guard self.isInTransaction else { throw GxCollectionDataSourceError.NotInTransaction(reason: "Cannot call remove function while not in a transaction.") }
        self.commandsQueue.sectionRowItemsToInsertByType[type.sectionId]?.append(GxDSCommandInsertQueue(type: type, value: value))
    }
    
    public func remove(row indexPath:IndexPath ) throws {
        guard self.isInTransaction else { throw GxCollectionDataSourceError.NotInTransaction(reason: "Cannot call remove function while not in a transaction.") }
        if let sectionItem = self.sectionsArray[safe: indexPath.section] {
            if let rowItem = sectionItem.values[safe: indexPath.row] {
                guard let type = self.tableRowSectionOrderAndIds.find(sectionId: sectionItem.sectionId, rowId: rowItem.type.rowId) else {
                    LOGE("Unable to find GxDataSourceRowSectionOrderedIdType for sectionId:\(sectionItem.sectionId) and optional rowId:\(rowItem.type.rowId)")
                    return
                }
                if sectionItem.values.count <= 1 {
                    /// remove section
                    try self.remove(section: type)
                    return;
                }
                /// if section alread set to be removed donot add this transaction
                if !self.commandsQueue.sectionsToDelete.contains(type.sectionId) {
                    /// if such a delete request does not exist, add it.
                    if !(self.commandsQueue.sectionRowItemsToDelete[type.sectionId]?.contains(indexPath.row) ?? false) {
                        self.commandsQueue.sectionRowItemsToDelete[type.sectionId]?.append(indexPath.row)
                    }
                }
            }
        }
    }
    
    public func remove(row type:GxDataSourceRowSectionOrderedIdType) throws {
        guard self.isInTransaction else { throw GxCollectionDataSourceError.NotInTransaction(reason: "Cannot call remove function while not in a transaction.") }
        if type.hasRowId {
            try self.remove(section: type)
        }
        /// Get indexPath from type
        else if let indexPath = self.sectionsArray.firstIndexPath(type: type) {
            try self.remove(row: indexPath)
        }
    }
    
    public func remove(section type:GxDataSourceRowSectionOrderedIdType ) throws{
        guard self.isInTransaction else { throw GxCollectionDataSourceError.NotInTransaction(reason: "Cannot call remove function while not in a transaction.") }
        if !self.commandsQueue.sectionsToDelete.contains(type.sectionId) {
            self.commandsQueue.sectionsToDelete.append(type.sectionId)
        }
    }
    
    //public var numberOfSections:Int {
    //    return self.tableRowSectionOrderAndIds.numberOfSections
    //}
    public func numberOfRowsInSection(_ section:Int ) -> Int {
        return self.sectionsArray.getSection(section: section)?.values.count ?? 0
    }
    
    public func getIndexPath(for type:GxDataSourceRowSectionOrderedIdType ) -> IndexPath? {
        return self.sectionsArray.firstIndexPath(type: type)
    }
    public func getSectionId(for section:Int) -> String? {
        //pthread_mutex_lock(&self.transactionMutexLock);
        let sectionId = self.sectionsArray.getSection(section: section)?.sectionId;
        //pthread_mutex_unlock(&self.transactionMutexLock);
        return sectionId
    }
    public func getSectionIndex(for sectionId:String) -> Int? {
        //pthread_mutex_lock(&self.transactionMutexLock)
        let val = self.sectionsArray.sectionOrder(sectionId: sectionId);
        //pthread_mutex_unlock(&self.transactionMutexLock)
        return val
    }
    
    public func getItem(for indexPath:IndexPath) -> PGXDataSourceRowItem? {
        //pthread_mutex_lock(&self.transactionMutexLock)
        let val = self.sectionsArray.getSection(section: indexPath.section)?.values[safe: indexPath.row]
        //pthread_mutex_unlock(&self.transactionMutexLock)
        return val
       }
}
