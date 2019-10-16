//
//  PGxDataChangeSet.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 9/4/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

public class GxDataChangeSet {
    public var insertions:[IndexPath]      = [IndexPath]()
    public var deletions:[IndexPath]       = [IndexPath]()
    public var modifications:[IndexPath]   = [IndexPath]()
    public var insertedSections:IndexSet   = IndexSet();
    public var deletedSections:IndexSet    = IndexSet();
    
    internal func clear() {
        self.insertions.removeAll()
        self.deletions.removeAll()
        self.modifications.removeAll()
        self.insertedSections.removeAll()
        self.deletedSections.removeAll()
    }
}
