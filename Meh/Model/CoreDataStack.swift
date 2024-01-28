//
//  CoreDataStack.swift
//  Meh
//
//  Created by Raj Raval on 28/01/24.
//

import Foundation
import CoreData

final class CoreDataStack {

    static let shared = CoreDataStack()

    let viewContext: NSManagedObjectContext

    private let persistentContainer: NSPersistentContainer
    private let modelName = "MehModel"

    private init() {
        let persistentContainer = NSPersistentContainer(name: modelName)
        let storeURL = URL.storeURL(for: Constants.appGroup, databaseName: modelName)
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load CoreDataStack with error: \(error.localizedDescription)")
            }
        }
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        self.persistentContainer = persistentContainer
        self.viewContext = persistentContainer.viewContext
    }

    func fetch<T: NSManagedObject>(
        _ entityClass: T.Type,
        sortBy sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) -> [T] {
        let entityName = String(describing: entityClass)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate

        do {
            let items = try viewContext.fetch(fetchRequest)
            return items
        } catch let error {
            Log.error(error)
            return []
        }
    }

    func fetchSingle<T: NSManagedObject>(
        _ entityClass: T.Type,
        sortBy sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) -> T? {
        let entityName = String(describing: entityClass)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1

        do {
            let items = try viewContext.fetch(fetchRequest)
            return items.first
        } catch let error {
            Log.error(error)
            return nil
        }
    }

    func checkIfEntityExists<T: NSManagedObject>(
        _ entityClass: T.Type,
        sortBy sortDescriptors: [NSSortDescriptor]? = nil,
        predicate: NSPredicate? = nil
    ) -> Bool {
        let entityName = String(describing: entityClass)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1

        do {
            let count = try viewContext.count(for: fetchRequest)
            return count > 0
        } catch let error {
            Log.error(error)
            return false
        }
    }

    func saveChanges() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                Log.error(error)
            }
        }
    }

}
