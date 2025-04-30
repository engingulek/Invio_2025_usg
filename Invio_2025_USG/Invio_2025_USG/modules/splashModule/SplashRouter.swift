//
//  SplashRouter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

//MARK: - SplashRouter
class SplashRouter {
    static func createSplashModule() -> UIViewController {
        let viewController = SplashViewController()
        let router = SplashRouter()
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(
            view: viewController,
            interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}

//MARK: SplashRouter :  PresenterToRouterSplashProtocol
extension SplashRouter :  PresenterToRouterSplashProtocol {
    func toHomeScreen(view:PresenterToViewSplashProtocol?,pageElement:PageElement) {
       // let viewController = HomeRouter.createHomeModule(pageElement: pageElement)
       // view?.pushViewControllerAble(viewController, animated: true)
    }
}
