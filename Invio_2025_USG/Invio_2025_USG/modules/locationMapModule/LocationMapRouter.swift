//
//  LocationMapRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

final class LocationMapRouter {
    static func createRouter(locationElement: LocationElement) -> UIViewController {
        let viewController = LocationMapViewController()
      
        let presenter  = LocationMapPresenter(
            view: viewController
            , mapLocationManager: MapLocationManager()
        )
        presenter.getLocationElement(locationElement: locationElement)
        viewController.presenter = presenter
       
        return viewController
    }
}
