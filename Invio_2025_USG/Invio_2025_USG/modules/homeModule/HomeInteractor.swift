//
//  HomeInteractor.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation


class HomeInteractor : PresenterToInteractorHomeProtocol {
    
    weak var presenter : InteractorToPresenterHomeProtocol?
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    
    func fetchPage(pageNumber: Int) async {
        guard let presenter = presenter else {return}
        
        do{
            let response = try await networkManager.fetch(
                target: .page(pageNumber), responseClass: PageElement.self)
            presenter.sendPage(page: response)
        }catch{
            presenter.sendError()
        }
    }
    
    func isEntityExist(id: Int16)  -> Bool {
        do{
            let state = try FavoriteCoreDataManager.shared.isEntityExist(id: id)
            return state
        }catch{
            presenter?.sendError()
            return false
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
