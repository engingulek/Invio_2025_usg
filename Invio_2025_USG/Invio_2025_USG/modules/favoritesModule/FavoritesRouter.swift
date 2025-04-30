//
//  FavoritesRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

//MARK: FavoritesRouter
// - Explanation: FavoriteRouter is responsible for handling navigation for the Favorite module.
class FavoritesRouter {
    static func createFavModule() -> UIViewController {
        let viewController = FavoritesViewController()
        let router = FavoritesRouter()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(view: viewController, interactor: interactor,router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
//MARK: PresenterToRouterFavoritesProtocol Methods
// - Explanation: This extension handles navigation requests sent from the presenter.
extension FavoritesRouter : PresenterToRouterFavoritesProtocol {
    
    ///  Navigate to the Detail screen with the given location data.
    /// - Parameters:
    ///   - view:  viewController for SegueAble
    ///   - locationElement:  location data for detail
    func toDetailScreen(view: PresenterToViewFavoritesProtocol?, locationElement: LocationElement) {
        let viewController = DetailRouter.createDetailModule(locationElement: locationElement)
        view?.pushViewControllerAble(viewController, animated: true)
    }
    
    
}
