//
//  SplashViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
import SnapKit

//MARK: - SplashViewController
class SplashViewController: UIViewController {
    
    private lazy var titleLabel = LabelFactory.createLabel(ofType: .bannerTitleLabel)
    private lazy var errorLabel = LabelFactory.createLabel(ofType: .errorLabel)
    
    var presenter :  ViewToPresenterSplashProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

//MARK: - SplashViewController :  PresenterToViewSplashProtocol
extension SplashViewController :  PresenterToViewSplashProtocol {
    func sendTitle(title: String,isHidden:Bool) {
        
        titleLabel.text = title
        titleLabel.isHidden = isHidden
        errorLabel.isHidden = !isHidden
        
    }
    func sendErrorMessage(text: String,isHidden:Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            errorLabel.text = text
            errorLabel.isHidden = isHidden
            titleLabel.isHidden = !isHidden
        }
    }
}
