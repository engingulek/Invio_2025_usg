//
//  FavoritesInteractor.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

//MARK: PresenterToInteractorFavoritesProtocol
class FavoritesInteractor : PresenterToInteractorFavoritesProtocol {
    
   weak var presenter : InteractorToPresenterFavoritesProtocol?
    
    /// fetch all favorites
    func fetchFavorites()  {
        do{
            let result =   try FavoriteCoreDataManager.shared.fetchAll()
            presenter?.sendFavorites(list: result)
            
        }catch{
            presenter?.sendError()
        }
    }
    
    /// delete location from favorite
    /// - Parameter id: id of location
    func deleteFav(id: Int16) {
        do{
            try FavoriteCoreDataManager.shared.deleteEntity(id: Int16(id))
            
        }catch{
            presenter?.sendError()
        }
    }
}
