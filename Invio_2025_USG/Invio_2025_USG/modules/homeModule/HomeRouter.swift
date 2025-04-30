//
//  HomeRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

import UIKit
//MARK: HomeRouter
// - Explanation: HomeRouter is responsible for handling navigation for the Home module.
class HomeRouter {
    static func createHomeModule(pageElement:PageElement) -> UIViewController {
        let viewController = HomeViewController()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter
        = HomePresenter(view: viewController, interactor: interactor, router: router)
        presenter.getFirstList(page: pageElement)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

//MARK: HomeRouter :  PresenterToRouterHomeProtocol

extension HomeRouter :  PresenterToRouterHomeProtocol {
   
    func toFavoritesScreen(view:PresenterToViewHomeProtocol?) {
        let viewController = FavoritesRouter.createFavModule()
        view?.pushViewControllerAble(viewController, animated: true)
    }
   
    func toDetailScreen(view: PresenterToViewHomeProtocol?, locationData: LocationElement) {
      let viewController = DetailRouter.createDetailModule(locationElement: locationData)
      view?.pushViewControllerAble(viewController, animated: true)
    }
   

    func toCityMap(view: PresenterToViewHomeProtocol?, cityElement: CityElement) {
        let viewController = CityMapRouter.crateCityMapModule(cityElement: cityElement)
       view?.pushViewControllerAble(viewController, animated: true)
    }
}
