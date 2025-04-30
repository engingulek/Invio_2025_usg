//
//  CityMapProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

typealias CityMapKits = UIViewAble & SegueAble & NavConUIAble & AlertControllerAble

//MARK: ViewToPresenterCityMapProtocol
protocol ViewToPresenterCityMapProtocol{
    var view : PresenterToViewCityMapProtocol? {get}
    func viewDidLoad()
    func getCityElement(cityElement:CityElement)
    
    func numberOfItemsIn() -> Int
    func cellForItem(at indexPath:IndexPath) -> (element:LocationElement,distance:String)
    func onTappedToDetailButton(itemIndex:Int)
    func didSelectItem(at indexPath:IndexPath)
    
    func onTappedFocusUserLocation()
    
}


//MARK: PresenterToViewCityMapProtocol
protocol PresenterToViewCityMapProtocol : AnyObject,CityMapKits {
    func prepareCollectionView()
    func reloadCollectionView()
    func onMap(annotationCoordinate: AnnotationCoordinate)
    func addDifferentLocations(annotationCoordinate: AnnotationCoordinate)
    func reloadMapViewAnnotation()
    func showUserLocation()
    func openSettingsPage()
    func focusUserLocation()
}



//MARK: PresenterToInteractorCityMapProtocol
protocol PresenterToInteractorCityMapProtocol{
    
}

//MARK: InteractorToPresenterSplashProtocol
protocol InteractorToPresenterCityMapProtocol{
    
}

//MARK: PresenterToRouterCityMapProtocol
protocol PresenterToRouterCityMapProtocol {
    func toDetail(view:PresenterToViewCityMapProtocol?,locationElement:LocationElement)
}
