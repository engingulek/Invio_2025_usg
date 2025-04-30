//
//  DetailViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
     var presenter : ViewToPresenterDetailProtocol!
    private lazy var locationImageView : UIImageView = UIImageView()
    private lazy var showOnMapButton = ButtonFactory.createButton(ofType: .basic(action:showOnMapAction ))
   
    

    private lazy var descLabel = LabelFactory.createLabel(ofType: .normalLabel)
    
    private lazy var showOnMapAction : UIAction = UIAction { _ in
        self.presenter.onTappednShowOnMapButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad(rightButtonAction:#selector(onTappedNavFavIcon) )
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(locationImageView)

      
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(200)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        view.addSubview(showOnMapButton)
        showOnMapButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        showOnMapButton.setTitle(TextTheme.showOnMap.localized, for: .normal)
    }
    
    
    @objc func onTappedNavFavIcon() {
        presenter.onTappedFavIcon()
    }
}


extension DetailViewController : PresenterToViewDetailProtocol {
    func sendDetailInfo(imageUrl: String?, detail: String) {
        locationImageView.setImageWithKigfisher(with: imageUrl)
        descLabel.text = detail
    }
    
    func sendErrorMessage(text: String, isHidden: Bool) {
        
    }
    
    
}
