//
//  SplashProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
//MARK: - SplashKits
typealias SplashKits = UIViewAble & SegueAble

//MARK: - ViewToPresenterSplashProtocol
protocol ViewToPresenterSplashProtocol {
    var view : PresenterToViewSplashProtocol? {get}
    func viewDidLoad()
}


//MARK: - PresenterToViewSplashProtocol
protocol PresenterToViewSplashProtocol : AnyObject,SplashKits {
    func sendTitle(title:String,isHidden:Bool)
    func sendErrorMessage(text:String,isHidden:Bool)
}



//MARK: - PresenterToInteractorSplashProtocol
protocol PresenterToInteractorSplashProtocol{
    func fetchFirstPage() async
}

//MARK: - InteractorToPresenterSplashProtocol
protocol InteractorToPresenterSplashProtocol : AnyObject{
    func sendFirsPage(page:PageElement)
    func sendError()
}

//MARK: - PresenterToRouterSplashProtocol
protocol PresenterToRouterSplashProtocol {
    func toHomeScreen(view:PresenterToViewSplashProtocol?,pageElement:PageElement)
}
