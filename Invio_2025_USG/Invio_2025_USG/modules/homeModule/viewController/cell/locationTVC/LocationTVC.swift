//
//  LocationTVC.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
import SnapKit


protocol LocationTVCDelegate {
    func onTappedFavIcon(indexPath:IndexPath?)
}

class LocationTVC: UITableViewCell {
    static let identifier = "locationTVCIdentifier"
    private lazy var locationNameLabel = LabelFactory.createLabel(ofType: .cellLabel(.left))
    
    var indexPath:IndexPath?
    var delegate : LocationTVCDelegate?
    private lazy var faviconButton = ButtonFactory.createButton(ofType:
            .iconButton(icon: .no_fav,
                        action: favIconButtonOnTapped,
                        color: .favColor))
  
   
    
    private lazy var favIconButtonOnTapped : UIAction = UIAction  { _ in
        self.delegate?.onTappedFavIcon(indexPath: self.indexPath)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        addSubview(locationNameLabel)
        locationNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
        }
        
        contentView.addSubview(faviconButton)
        faviconButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.size.equalTo(30)
        }
        
    }
    

    func configureData(locationName:String,favState:FavState) {
        let imageType = favState == .favoritee ? IconTheme.fav.rawValue : IconTheme.no_fav.rawValue
        locationNameLabel.text = locationName
        let image = UIImage(systemName: imageType)
        faviconButton.setImage(image, for: .normal)
    }
}
