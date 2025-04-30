//
//  DetailInteractor.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

class DetailInteractor : PresenterToInteractorDetailProtocol {
   weak var presenter : InteractorToPresenterDetailProtocol?
    func isEntityExist(id: Int16)  {
        do{
            let state = try FavoriteCoreDataManager.shared.isEntityExist(id: id)
            presenter?.sendSuccess(state: state)
        }catch{
            presenter?.sendError()
        }
    }
    
    func deleteFav(id: Int16) {
        do{
            try FavoriteCoreDataManager.shared.deleteEntity(id: Int16(id))
           
        }catch{
            presenter?.sendError()
        }
    }
    
    func addToFav(element: LocationElement) {
        do{
            try FavoriteCoreDataManager.shared.addEntity(model: element)
        }catch{
            presenter?.sendError()
        }
    }
}
