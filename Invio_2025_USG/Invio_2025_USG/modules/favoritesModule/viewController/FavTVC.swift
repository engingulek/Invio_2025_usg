//
//  FavTVC.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

//MARK: FavTVCDelegate
protocol FavTVCDelegate {
    func onTappedFavIcon(indexPath:IndexPath?)
}

//MARK: FavTVC
class FavTVC: UITableViewCell {
    static let identifier:String = "FavTVCIdentifier"
    var delegate : FavTVCDelegate?
    private lazy var locationNameLabel = LabelFactory.createLabel(ofType: .cellLabel(.natural))
    private lazy var faviconButton = ButtonFactory.createButton(ofType:
            .iconButton(icon: .fav,
                        action: favIconButtonOnTapped,
                        color: .favColor))
    var indexPath:IndexPath?
    
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
    
    func configureData(name:String){
        locationNameLabel.text = name
    }

}
