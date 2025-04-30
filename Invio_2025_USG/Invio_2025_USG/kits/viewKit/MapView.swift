//
//  MapView.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import MapKit
import SnapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var iconType: IconTheme

    init(coordinate: CLLocationCoordinate2D, iconType: IconTheme) {
        self.coordinate = coordinate
        
        self.iconType = iconType
    }
}

class MapUIView : BaseView<UIViewController>{
    private let mapView = MKMapView()
    let annotation = MKPointAnnotation()
    
    override func setupView() {
        super.setupView()
        mapView.delegate = self
        
        configureView()
        
    }
    
    private func configureView() {
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showUserLocation() {
        mapView.showsUserLocation = true
       
    }
    
    func focusUserLocation() {
        mapView.userTrackingMode = .follow
    }
    
    func reloadMapViewAnnotation() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    // Add base coordinate on map view
    func onMap(annotationCoordinate: AnnotationCoordinate)  {

        let coordinate = CLLocationCoordinate2D(latitude: annotationCoordinate.latitude,
                                                longitude: annotationCoordinate.longitude)

        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: annotationCoordinate.meters,
                                        longitudinalMeters: annotationCoordinate.meters)
        mapView.setRegion(region, animated: true)
    
        let centerAnnotation = CustomAnnotation(coordinate: coordinate,iconType: .pin_location)
    annotation.coordinate = coordinate
        mapView.addAnnotation(centerAnnotation)
    }
    
    // Add cordinate on mapview
    func addDifferentLocations(annotationCoordinate:AnnotationCoordinate){
        let coordinate = CLLocationCoordinate2D(latitude: annotationCoordinate.latitude,
                                                longitude: annotationCoordinate.longitude)
     
        let diffrentAnnotaion = CustomAnnotation(coordinate: coordinate,iconType: .mappin)
        mapView.addAnnotation(diffrentAnnotaion)
    }
}


extension MapUIView : MKMapViewDelegate {
    // Create pin on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }

        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = customAnnotation
        }
        
        annotationView?.image = UIImage(named: customAnnotation.iconType.rawValue)
        annotationView?.snp.makeConstraints({ make in
            make.size.equalTo(50)
        })
        return annotationView
    }
}
