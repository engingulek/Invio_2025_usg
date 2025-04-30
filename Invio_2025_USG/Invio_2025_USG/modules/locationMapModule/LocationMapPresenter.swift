//
//  LocationMapPresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

final class LocationMapPresenter {
    
    
    weak var view: PresenterToViewLocationMapProtocol?
    private var mapLocationManager : MapLocationManagerProtocol
    private var element : LocationElement?
    private var isFocusTapped = false
    private var toOpenSettingsPage : Bool = false
    
    
    init(view: PresenterToViewLocationMapProtocol?,mapLocationManager:MapLocationManagerProtocol) {
        self.view = view
        self.mapLocationManager = mapLocationManager
        
    }
}


extension LocationMapPresenter : ViewToPresenterLocationMapProtocol {
    
    func viewDidLoad() {
        mapLocationManager.delegate = self
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
        guard let element = element else {return}
        let annotationCoordinate = AnnotationCoordinate(latitude: element.coordinates.lat,
                                                        longitude: element.coordinates.lng, meters: 300, type: .star)
        let pinImage = IconTheme.pin_location.rawValue
        view?.onMap(pinImage: pinImage, annotationCoordinate: annotationCoordinate)
        
    }
    
    func viewWillAppear() {
        mapLocationManager.delegate = self
    }
    
    
    func getLocationElement(locationElement: LocationElement) {
        element = locationElement
        view?.setNavigationTitle(title: locationElement.name)
        view?.hidedBackAble(isHidden: false)
        
    }
    
    func onTappedFocusUserLocation() {
        
        isFocusTapped = true
        mapLocationManager.focusUserLocationAuthorization()
        
        
    }
    
    func onTappedGetDirectionButton() {
        guard let element = element else {return}
        view?.createActionSheet(title: TextTheme.mapType.localized,
                                message: TextTheme.mapQ.localized, sections: [
                                    .init(title: "Apple Maps", action: {
                                        
                                        self.view?.openMapRoute(
                                            url: "http://maps.apple.com/?daddr=\(element.coordinates.lat),\(element.coordinates.lng)",
                                            storeUrl: "https://apps.apple.com/us/app/maps/id915056765")
                                    }),
                                    .init(title: "Yandex Maps", action: {
                                        
                                        self.view?.openMapRoute(
                                            url: "yandexmaps://build_route?lat_to=\(element.coordinates.lat)lon_to=\(element.coordinates.lng)",
                                            storeUrl: "https://apps.apple.com/us/app/yandex-maps/id474713765")
                                    }),
                                ])
    }
}


extension LocationMapPresenter : MapLocationManagerDelegate {
    
    func focusUserLocation(state: FocusUserLocationState) {
        isFocusTapped = true
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
        switch state {
        case .successful:
            mapLocationManager.requestLocationAccess()
            view?.showUserLocation()
            if isFocusTapped {
                view?.focusUserLocation()
            }
            
        case .notDetermined:
            createAlertMessage()
            
        case .denied:
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
    
    private func createAlertMessage() {
        view?.createAlert(title: TextTheme.warning.localized, message: TextTheme.locationAlertMessage.localized,
                          positiveSection: .init(title: TextTheme.yes.localized, action: onTappedYesButton),
                          negationSection: .init(title: TextTheme.no.localized, action: {}))
    }
    
    private func onTappedYesButton() {
        
        if(toOpenSettingsPage == true){
            view?.openSettingsPage()
        }else{
            mapLocationManager.requestLocationAccess()
            toOpenSettingsPage = true
        }

    }
}

