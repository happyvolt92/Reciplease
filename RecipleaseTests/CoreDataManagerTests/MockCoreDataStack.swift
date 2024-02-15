//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by elodie gage on 15/02/2024.
//    
//

import Foundation
import CoreData
@testable import Reciplease

class MockCoreDataStack: CoreDataStack {
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        let desc = NSPersistentStoreDescription()
        desc.type = NSInMemoryStoreType
        self.persistentContainer.persistentStoreDescriptions = [desc]
    }
}
