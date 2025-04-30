//
//  LocationMapProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import Foundation
typealias LocationMapKits = UIViewAble & SegueAble & NavConUIAble & AlertControllerAble & ActionSheetAble

protocol ViewToPresenterLocationMapProtocol {
    var view : PresenterToViewLocationMapProtocol? {get}
    func viewDidLoad()
    func viewWillAppear()
    func getLocationElement(locationElement:LocationElement)
    func onTappedFocusUserLocation()
    func onTappedGetDirectionButton()
}


//MARK: PresenterToViewLocationMapProtocol
protocol PresenterToViewLocationMapProtocol : AnyObject,LocationMapKits {
   func onMap(pinImage:String,annotationCoordinate:AnnotationCoordinate)
   func showUserLocation()
    func openSettingsPage()
    func focusUserLocation()
    func openMapRoute(url:String,storeUrl:String)
}


/*
//MARK: PresenterToInteractorLocationMapProtocol
protocol PresenterToInteractorLocationMapProtocol{
   
}

//MARK: InteractorToPresenterLocationMapProtocol
protocol InteractorToPresenterLocationMapProtocol{
   
}

//MARK: PresenterToRouterSplashProtocol
protocol PresenterToRouterLocationMapProtocol {
   
} */
