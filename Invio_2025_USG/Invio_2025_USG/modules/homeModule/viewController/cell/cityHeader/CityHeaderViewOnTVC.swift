//
//  CityHeaderViewOnTVC.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
import SnapKit

protocol CityHeaderViewOnTVCDelegate {
    func sectionOnTapped(_ sectionIndex:Int)
    func onTappedRightArrow(_ sectionIndex:Int)
}

enum ExpendType {
    case open
    case close
    case none
}

class CityHeaderViewOnTVC : UIView  {
    var delegate : CityHeaderViewOnTVCDelegate?
    private lazy var titleLabel = LabelFactory.createLabel(ofType: .cellTitleLabel)
    private var sectionIndex:Int = 0
    private lazy var expandIconType:UIImageView = UIImageView()
    
    private lazy var rightArrowIconButton = ButtonFactory.createButton(ofType:
            .iconButton(icon: .rigth_arrow,
                        action: rightArrowIconTappedAction,
                        color: .secondaryColor))
    
    private lazy var rightArrowIconTappedAction : UIAction = UIAction { _ in
        self.delegate?.onTappedRightArrow(self.sectionIndex)
    }
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(35)
            make.trailing.equalToSuperview()
        }
        
        titleLabel.isUserInteractionEnabled = true
        let sectionTapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionOnTappedAction))
        titleLabel.addGestureRecognizer(sectionTapGesture)
    
        addSubview(expandIconType)
        expandIconType.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalToSuperview()
            
        }
        
        addSubview(rightArrowIconButton)
        rightArrowIconButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(20)
        }
            
    }
    
    func configureData(title:String,type:ExpendType,section:Int) {
        titleLabel.text = title
        sectionIndex = section
        expandIconType.tintColor = .black
        switch type {
        case .open:
           
            expandIconType.image = UIImage(systemName: IconTheme.minus.rawValue)
            rightArrowIconButton.isHidden = false
            
    
        case .close:
            expandIconType.image = UIImage(systemName: IconTheme.plus.rawValue)
            rightArrowIconButton.isHidden = false
        case .none:
            rightArrowIconButton.isHidden = true
           return
        }
        
    }
    
    @objc func sectionOnTappedAction() {
        delegate?.sectionOnTapped(sectionIndex)
    }
    
  
}
