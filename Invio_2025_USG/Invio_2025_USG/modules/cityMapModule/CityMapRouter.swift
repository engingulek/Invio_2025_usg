//
//  CityMapRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

class CityMapRouter {
    static func crateCityMapModule(cityElement:CityElement) -> UIViewController {
        let viewController = CityMapScreenViewController()
        let router = CityMapRouter()
        let presenter : ViewToPresenterCityMapProtocol = CityMapPresenter(
            view: viewController,
            router: router,
           mapLocationManager: MapLocationManager()
        )
        presenter.getCityElement(cityElement: cityElement)
        viewController.presenter = presenter
        return viewController
    }
}

extension CityMapRouter : PresenterToRouterCityMapProtocol {
    func toDetail(view: PresenterToViewCityMapProtocol?, locationElement: LocationElement) {
        let viewController = DetailRouter.createDetailModule(locationElement: locationElement)
        view?.pushViewControllerAble(viewController, animated: true)
    }
}
