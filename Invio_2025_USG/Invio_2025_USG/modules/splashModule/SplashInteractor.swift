//
//  SplashInteractor.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

//MARK: - SplashInteractor
class SplashInteractor : PresenterToInteractorSplashProtocol {
    
    weak var presenter : InteractorToPresenterSplashProtocol?
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    func fetchFirstPage() async {
        guard let presenter  = presenter else {return}
        do{
            let response = try await networkManager.fetch(
                target: .page(1), responseClass: PageElement.self)
            presenter.sendFirsPage(page: response)
        }catch{
            presenter.sendError()
        }
        
    }
}
