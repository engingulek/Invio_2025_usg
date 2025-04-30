//
//  LocationMapViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

class LocationMapViewController: UIViewController, PresenterToViewLocationMapProtocol {

    var presenter: ViewToPresenterLocationMapProtocol!
    private lazy var focusUserLocationButton = ButtonFactory.createButton(ofType: .iconButton(
        icon: IconTheme.focus_user, action: focusUserLocationButttonAction, color: ColorTheme.secondaryColor, backColor: ColorTheme.primaryColor))
    
    private lazy var getDirectionButton = ButtonFactory.createButton(ofType: .basic(action:getDirectionButtonAction ))
    
    
    private lazy var mapView = MapUIView(self)
    
    private lazy var focusUserLocationButttonAction : UIAction = UIAction { _ in
        self.presenter.onTappedFocusUserLocation()
    }
    
    private lazy var getDirectionButtonAction : UIAction = UIAction { _ in
        self.presenter.onTappedGetDirectionButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        configureUI()
        view = mapView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    
    private func configureUI() {
        
        
        
        mapView.addSubview(getDirectionButton)
        getDirectionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        mapView.addSubview(focusUserLocationButton)
        focusUserLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(getDirectionButton.snp.top).offset(-20)
            make.trailing.equalToSuperview().offset(-30)
            make.size.equalTo(40)
        }
        
        getDirectionButton.setTitle(TextTheme.getDirection.localized, for: .normal)
        
        
    }
    
    func onMap(pinImage: String, annotationCoordinate: AnnotationCoordinate) {
        mapView.onMap(annotationCoordinate: annotationCoordinate)
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
    
    func openMapRoute(url: String,storeUrl:String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if let appStoreURL = URL(string: storeUrl) {
                    UIApplication.shared.open(appStoreURL)
                }
            }
        }
    }
    
}

