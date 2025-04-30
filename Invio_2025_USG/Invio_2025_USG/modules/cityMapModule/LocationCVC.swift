//
//  LocationCVC.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

protocol LocationCVCDelegate {
    func onTappedToDetailButton(itemIndex:Int)
}

class LocationCVC : UICollectionViewCell {
    static  let identifier : String  = "locationCvc"
    private lazy var locationImage:UIImageView = UIImageView()
    private lazy var locationName = LabelFactory.createLabel(ofType: .cellLabel(.center))
    private lazy var toDetailButton = ButtonFactory.createButton(ofType: .basic(action: toDetailButtonAction))
    private lazy var distanceLabel = LabelFactory.createLabel(ofType: .cellLabel(.center))
    var itemIndex:Int = 0
    var delegate:LocationCVCDelegate?
    
    private lazy var toDetailButtonAction : UIAction = UIAction {_ in
        self.delegate?.onTappedToDetailButton(itemIndex: self.itemIndex)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(locationImage)
        locationImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(120)
        }
        
        contentView.addSubview(locationName)
        locationName.snp.makeConstraints { make in
            make.top.equalTo(locationImage.snp.top)
            make.leading.equalTo(locationImage.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(locationName.snp.bottom)
            make.leading.equalTo(locationImage.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(toDetailButton)
        toDetailButton.snp.makeConstraints { make in
            make.bottom.equalTo(locationImage.snp.bottom)
            make.leading.equalTo(locationImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        toDetailButton.setTitle(TextTheme.goDetail.localized, for: .normal)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
    }
    
    
    func configureData(locationElement:LocationElement,distance:String) {
        locationImage.setImageWithKigfisher(with: locationElement.image)
        locationName.text = locationElement.name
        distanceLabel.text = distance
    }
    
    
}
