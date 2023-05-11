//
//  Persistence.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//

import CoreData

internal final class PersistenceController {
    
    internal enum PersistenceError: Error {
        case requestedItemNotFound
    }

    internal static let shared = PersistenceController()
    internal let container: NSPersistentContainer
    internal var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    internal var fetchControllers: [String: FetchResultControllerProtocol]
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "lokomond")
        self.fetchControllers = [:]
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
