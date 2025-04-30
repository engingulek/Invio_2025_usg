//
//  CoreDataManaging.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import CoreData

//MARK: CoreDataError
enum CoreDataError : Error {
    case fetchError
    case addError
    case deleteError
    case isExistError
}
//MARK: CoreDataManaging
protocol CoreDataManaging {
    
    associatedtype Entity: NSManagedObject
    associatedtype AddModel : Any
    
    func fetchAll() throws -> [Entity]
    func addEntity(model: AddModel) throws
    func deleteEntity(id: Int16) throws
    func isEntityExist(id: Int16) throws -> Bool
}
