//
//  FavoriteCoreDataManager.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

import CoreData

//MARK: - FavoriteCoreDataManager
final class FavoriteCoreDataManager {
   
    static let shared = FavoriteCoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - CoreDataManaging Methods
extension FavoriteCoreDataManager : CoreDataManaging {
    
    typealias Entity = Favorite
    typealias AddModel = LocationElement
    // fetch all favorite
    func fetchAll() throws -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw CoreDataError.fetchError
        }
    }
    // add entity to favorite
    func addEntity(model : AddModel) throws {
        let favorite = Favorite(context: context)
        favorite.id = Int16(model.id)
        favorite.name = model.name
        favorite.desc = model.description
        favorite.latitude = model.coordinates.lat
        favorite.longitude = model.coordinates.lng
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.addError
        }
    }
    
    // delete from favorite
    func deleteEntity(id: Int16) throws {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            if let favoriteToDelete = favorites.first {
                context.delete(favoriteToDelete)
                try context.save()
            }
        } catch {
            throw CoreDataError.deleteError
        }
    }
    
    // check control
    func isEntityExist(id: Int16) throws -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return !favorites.isEmpty
        } catch {
            throw CoreDataError.isExistError
        }
    }
}
