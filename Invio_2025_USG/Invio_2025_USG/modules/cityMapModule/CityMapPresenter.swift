//
//  CityMapPresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
final class CityMapPresenter{
    weak var view : PresenterToViewCityMapProtocol?
    private let router : PresenterToRouterCityMapProtocol
    private var mapLocationManager : MapLocationManagerProtocol
    private var cityValue : CityElement?
    private var locationList : [LocationElement] = []
    private var selectedIndex:Int = 0
    private var isFocusTapped = false
    private var toOpenSettingsPage : Bool = false
    private var userLocation:(lat:Double,lng:Double)?
    
    init(view: PresenterToViewCityMapProtocol?,
         router: PresenterToRouterCityMapProtocol,
         mapLocationManager : MapLocationManagerProtocol
    ) {
        self.view = view
        self.router = router
        self.mapLocationManager = mapLocationManager
    }
}


extension CityMapPresenter : ViewToPresenterCityMapProtocol {
    
    func viewDidLoad() {
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
        view?.hidedBackAble(isHidden: false)
      
        guard let cityValue = cityValue else {
            view?.setNavigationTitle(title: "")
            return
        }
        view?.setNavigationTitle(title: cityValue.city)
        locationList = cityValue.locations
        view?.prepareCollectionView()
        view?.reloadCollectionView()
        
        mapLocationManager.delegate = self
        
        
        pinCreateOnMap()
    
    }
    
    func onTappedFocusUserLocation() {
        isFocusTapped = true
        
        mapLocationManager.focusUserLocationAuthorization()
    }
    
    func numberOfItemsIn() -> Int {
        return locationList.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> (element:LocationElement,distance:String) {
        let element = locationList[indexPath.item]
        guard let userLocation = userLocation else {return  (element:element,distance:"")}
        let result =  mapLocationManager.calculateDistance(
            point: (lat: userLocation.lat, lng: userLocation.lng),
            target: (lat: element.coordinates.lat, lng: element.coordinates.lng))
        
        let km = result / 1000
        let type = km >= 1 ? "km" : "m"
        return (element:element,distance:"\(String(format: "%.2f", result)) \(type)")
    }
    
  
    
   
    
   

    
    
  private func  pinCreateOnMap() {
        locationList.enumerated().forEach { index,_ in
            let item = locationList[index]
            if index == selectedIndex {
                view?.onMap(
                            annotationCoordinate: AnnotationCoordinate(latitude: item.coordinates.lat, longitude: item.coordinates.lng, meters: 4000, type: .star))
            }else{
                view?.addDifferentLocations(annotationCoordinate: AnnotationCoordinate(
                    latitude:item.coordinates.lat , longitude: item.coordinates.lng, meters: 4000, type: .pin))
            }
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        view?.reloadMapViewAnnotation()
        selectedIndex = indexPath.item
        pinCreateOnMap()
       
    }
    
    func getCityElement(cityElement: CityElement) {
        cityValue = cityElement
      
     
        
    }
    
    
    func onTappedToDetailButton(itemIndex:Int) {
        let element = locationList[itemIndex]
        router.toDetail(view: view, locationElement: element)
    }
}

extension CityMapPresenter : MapLocationManagerDelegate {
  
    
    
    func focusUserLocation(state: FocusUserLocationState) {
        switch state {
        case .focus:
            view?.focusUserLocation()
        case .notDetermined:
            mapLocationManager.requestLocationAccess()
        case .denied:
            view?.openSettingsPage()
        }
    }
    
    func locationPermisson(state: LocationPermissonState) {
       print("testila")
        switch state {
        case .successful:
            print("Presenter Successful")
            mapLocationManager.requestLocationAccess()
            view?.showUserLocation()
            if isFocusTapped {
                view?.focusUserLocation()
            }
            
        case .notDetermined:
         
            
            print("can 1")
            createAlertMessage()
          //  MapLocationManager.shared.requestLocationAccess()
        case .denied:
            //view?.openSettingsPage()
            if(isFocusTapped){
                view?.openSettingsPage()
            }else{
                if(toOpenSettingsPage == false) {
                    createAlertMessage()
                }
                toOpenSettingsPage = true
            }
        }
    }
    

    
   func didUpdateLocation(_ location: (lat: Double, lng: Double)) {
        userLocation = location
        
     locationList =    locationList.sorted {
         mapLocationManager.calculateDistance(point: location, target: (lat: $0.coordinates.lat, lng: $0.coordinates.lng))
            <
                mapLocationManager.calculateDistance(point: location, target: (lat: $1.coordinates.lat, lng: $1.coordinates.lng))
        }
        
        view?.reloadCollectionView()
        pinCreateOnMap()
        
    }
    
    private func createAlertMessage() {
        view?.createAlert(title: TextTheme.warning.localized, message: TextTheme.locationAlertMessage.localized,
                          positiveSection: .init(title: TextTheme.yes.localized, action: onTappedYesButton),
                          negationSection: .init(title: TextTheme.no.localized, action: {}))
    }
    
    private func onTappedYesButton() {
        isFocusTapped = true
        mapLocationManager.requestLocationAccess()
        
    }
    
    
}
