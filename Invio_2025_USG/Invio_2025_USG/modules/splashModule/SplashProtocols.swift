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
    // Sends title and status to view
    func sendTitle(title:String,isHidden:Bool)
    // Send error title and status to view
    func sendErrorMessage(text:String,isHidden:Bool)
}



//MARK: - PresenterToInteractorSplashProtocol
protocol PresenterToInteractorSplashProtocol{
    // Get first page
    func fetchFirstPage() async
}

//MARK: - InteractorToPresenterSplashProtocol
protocol InteractorToPresenterSplashProtocol : AnyObject{
    // sends the first page information that comes up
    func sendFirsPage(page:PageElement)
    // if there is an error it sends an error
    func sendError()
}

//MARK: - PresenterToRouterSplashProtocol
protocol PresenterToRouterSplashProtocol {
    // navigation for home screen
    func toHomeScreen(view:PresenterToViewSplashProtocol?,pageElement:PageElement)
}
