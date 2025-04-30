//
//  SceneDelegate.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: SplashRouter.createSplashModule())
        window?.rootViewController =  navigationController
        navigationController.navigationBar.tintColor = .black
        window?.makeKeyAndVisible()
    }
}

