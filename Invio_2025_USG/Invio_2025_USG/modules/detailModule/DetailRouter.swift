//
//  DetailRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
class DetailRouter {
    static func createDetailModule(locationElement:LocationElement) -> UIViewController {
        let viewController = DetailViewController()
        let router = DetailRouter()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(view: viewController, router: router,interactor: interactor)
        interactor.presenter = presenter
        presenter.getLocationData(locationElement)
        viewController.presenter = presenter
        
        return viewController
    }
}


extension DetailRouter : PresenterToRouterDetailProtocol {
    func toLocationMap(view: PresenterToViewDetailProtocol?, locationElement: LocationElement) {
      //  let viewController = LocationMapRouter.createRouter(locationElement: locationElement)
      //  view?.pushViewControllerAble(viewController, animated: true)
    }
}
