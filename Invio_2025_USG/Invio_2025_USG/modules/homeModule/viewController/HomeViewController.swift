//
//  HomeViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
//MARK: HomeViewController
class HomeViewController: UIViewController {
   
    var presenter : ViewToPresenterHomeProtocol!
    
    private lazy var cityTableView = UITableView()
    private lazy var cityCountLabel = LabelFactory.createLabel(ofType: .normalLabel)
    private lazy var errorLabel = LabelFactory.createLabel(ofType: .errorLabel)
    private lazy var collapseIconButton = ButtonFactory.createButton(ofType:
            .iconButton(icon: IconTheme.closeCollapseIcon,
                        action: collapseIconButtonAction,
                        color: ColorTheme.primaryColor,
                        backColor: ColorTheme.secondaryColor
                       ))
    
    private lazy var collapseIconButtonAction : UIAction = UIAction { _ in
        self.presenter.onTappedCollapseIconButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(rightButtonAction: #selector(onTappedNavFavIcon))
        configureData()
        cityTableView.register(LocationTVC.self, forCellReuseIdentifier: LocationTVC.identifier)
        cityTableView.reloadData()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityTableView.reloadData()
    }
    
    private func configureData() {
        view.addSubview(cityCountLabel)
        cityCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }
        view.addSubview(cityTableView)
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(cityCountLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
          
        }
        
        view.addSubview(collapseIconButton)
        collapseIconButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.trailing.equalToSuperview().offset(-30)
            make.size.equalTo(50)
        }
        collapseIconButton.layer.cornerRadius = 10
        
    }
    
    @objc func onTappedNavFavIcon() {
        presenter.onTappedNavFavIcon()
    }
}


extension HomeViewController : PresenterToViewHomeProtocol {
  
    func collapseButtonIsHidden(isHidden: Bool) {
        collapseIconButton.isHidden = isHidden
    }
    
   
    func prepareTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    
  
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            cityTableView.reloadData()
        }
    }
    
    
    func reloadSection(index: Int) {
        let indexSet = IndexSet(integer: index)
        cityTableView.reloadSections(indexSet, with: .fade)
    }
    
   
    func reloadIndexPath(indexPath:IndexPath) {
        cityTableView.reloadRows(at: [indexPath], with: .none)
    }
    
  
    func cityCountText(text: String, count: Int,isHidden:Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            cityCountLabel.text = text + ": \(count)"
            cityCountLabel.isHidden = isHidden
            cityTableView.isHidden = isHidden
            errorLabel.isHidden = !isHidden
        }
    }
    
  
    func sendError(text: String, isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            cityCountLabel.isHidden = !isHidden
            cityTableView.isHidden = !isHidden
            errorLabel.isHidden = isHidden
        }
    }
}
