//
//  CoreDataStack.swift
//  Tasks
//
//  Created by Joseph Rogers on 12/3/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    //can only be one instance of this class ever/Singleton
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let newContainer = NSPersistentContainer(name: "Tasks")
        newContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("Failed to load persistent stores: \(error!)")
            }
        }
        return newContainer
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}
