//
//  MapLocationManager.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import CoreLocation

//MARK: LocationPermissonState
/// Represents the state of location permission.
enum LocationPermissonState {
    case successful   /// User has granted location permission.
    case notDetermined /// User has not made a choice regarding location permission yet.
    case denied ///  User has denied location permission.
}

//MARK: FocusUserLocationState
/// Represents the state of focusing on the user's location.
enum FocusUserLocationState {
    case focus /// Map can focus on user's location.
    case notDetermined /// Permission state is not determined yet.
    case denied /// Cannot focus due to denied permission.
}

//MARK: MapLocationManagerDelegate
/// Protocol to handle location-related delegate callbacks.
protocol MapLocationManagerDelegate: AnyObject {
    
    /// Called when the location permission state changes.
    /// - Parameter state: The current permission state.
    func locationPermisson(state:LocationPermissonState)
    /// Called to indicate the ability to focus on the user's location.
    /// - Parameter state: The current focus state.
    func focusUserLocation(state:FocusUserLocationState)
    /// Called when a new location is received.
    /// - Parameter location: A tuple containing latitude and longitude.
    func didUpdateLocation(_ location: (lat:Double,lng:Double))
}


/// Provides a default implementation to make `didUpdateLocation` optional.
extension MapLocationManagerDelegate {
    func didUpdateLocation(_ location: (lat:Double,lng:Double)){
    }
}
protocol MapLocationManagerProtocol {
    var delegate: MapLocationManagerDelegate? {get set}
    /// Requests location permission from the user.
    func requestLocationAccess()
    /// Checks whether the app can focus on the user's location based on current permission status.
    func focusUserLocationAuthorization()
    /// Calculates the distance between two geographic points.
    /// - Parameters:
    ///   - point: The first coordinate (latitude, longitude).
    ///   - target: The second coordinate (latitude, longitude).
    /// - Returns: The distance in meters.
    func calculateDistance(point:(lat:Double,lng:Double),target:(lat:Double,lng:Double)) -> Double
}

//MARK: MapLocationManager
/// A singleton class responsible for managing location services.
final class MapLocationManager: NSObject {
   
    
    private let locationManager = CLLocationManager()
    weak var delegate: MapLocationManagerDelegate?
    
    /// Initializes the location manager and sets its properties.
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

//MARK: CLLocationManagerDelegate Methods
extension MapLocationManager : CLLocationManagerDelegate  {
    /// Called when the authorization status for the app changes.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            delegate?.locationPermisson(state: .successful)
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            delegate?.locationPermisson(state: .denied)
        case .notDetermined:
            delegate?.locationPermisson(state: .notDetermined)
            break
        @unknown default:
            break
        }
    }
    /// Called when new location data is available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        delegate?.didUpdateLocation((lat: location.coordinate.latitude, lng: location.coordinate.longitude))
    }
}


//MARK: MapLocationManagerProtocol Methods
extension MapLocationManager : MapLocationManagerProtocol {
    func requestLocationAccess() {
        
        locationManager.requestWhenInUseAuthorization()
        
    }
   
    func focusUserLocationAuthorization() {
        
        let status =  locationManager.authorizationStatus
        switch status {
        case .denied,.restricted:
            delegate?.focusUserLocation(state: .denied)
        case .authorizedAlways,.authorizedWhenInUse:
            delegate?.focusUserLocation(state: .focus)
        case .notDetermined:
            delegate?.focusUserLocation(state: .notDetermined)
        @unknown default:
            break
        }
        
    }

    func calculateDistance(point:(lat:Double,lng:Double),target:(lat:Double,lng:Double)) -> Double {
        let pointLoc = CLLocation(latitude: point.lat, longitude: point.lng)
        let targetLoc = CLLocation(latitude: target.lat, longitude: target.lng)
        let  result = pointLoc.distance(from: targetLoc)
        return result
    }
}
