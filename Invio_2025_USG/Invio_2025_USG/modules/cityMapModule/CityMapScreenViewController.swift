//
//  CityMapScreenViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
class CityMapScreenViewController: UIViewController {
    var presenter : ViewToPresenterCityMapProtocol!
    private lazy var locationCollectionView : UICollectionView = UICollectionView.primaryCollectionView(scroolDirection: .horizontal)
    private lazy var focusUserLocationButton = ButtonFactory.createButton(ofType: .iconButton(
         icon: IconTheme.focus_user, action: focusUserLocationButttonAction, color: ColorTheme.secondaryColor, backColor: ColorTheme.primaryColor))
    private lazy var mapView = MapUIView(self)
    
    private lazy var focusUserLocationButttonAction : UIAction = UIAction { _ in
        self.presenter.onTappedFocusUserLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        view = mapView
        
        locationCollectionView.register(LocationCVC.self, forCellWithReuseIdentifier: LocationCVC.identifier)
        
        mapView.addSubview(locationCollectionView)
        locationCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        locationCollectionView.layer.cornerRadius = 10
        locationCollectionView.backgroundColor = .clear
        
        mapView.addSubview(focusUserLocationButton)
        focusUserLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(locationCollectionView.snp.top).offset(-10)
            make.trailing.equalToSuperview().offset(-30)
            make.size.equalTo(40)
        }
    }
}


extension CityMapScreenViewController : PresenterToViewCityMapProtocol {
  

    func onMap(annotationCoordinate: AnnotationCoordinate) {
        mapView.onMap(annotationCoordinate: annotationCoordinate)
    }
    
    func addDifferentLocations(annotationCoordinate: AnnotationCoordinate) {
        mapView.addDifferentLocations(annotationCoordinate:annotationCoordinate)
    }
    
    func prepareCollectionView() {
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        
    }
    
    func reloadCollectionView() {
        locationCollectionView.reloadData()
    }
    
    func reloadMapViewAnnotation() {
        mapView.reloadMapViewAnnotation()
    }
    
    func showUserLocation() {
        mapView.showUserLocation()
    }
    
    func openSettingsPage() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func focusUserLocation() {
        self.mapView.focusUserLocation()
    }
    
    
   
    
}

extension CityMapScreenViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsIn()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCVC.identifier, for: indexPath) as? LocationCVC else {return UICollectionViewCell()}
        cell.delegate = self
        cell.itemIndex = indexPath.item
        let item =   presenter.cellForItem(at: indexPath)
        cell.configureData(locationElement: item.element,distance: item.distance)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension CityMapScreenViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let cellWidth = width - 50
        let cellHeight = height / 7
        
        return CGSize(width: cellWidth, height:cellHeight )
    }
    
   
}



extension CityMapScreenViewController : LocationCVCDelegate {
    func onTappedToDetailButton(itemIndex: Int) {
        presenter.onTappedToDetailButton(itemIndex: itemIndex)
    }
}
