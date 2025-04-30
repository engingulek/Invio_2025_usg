//
//  FavoritesViewController.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
import SnapKit
class FavoritesViewController: UIViewController {
   private lazy var favTableView = UITableView()
    private lazy var messageLabel = LabelFactory.createLabel(ofType: .errorLabel)
    
    var presenter : ViewToPresenterFavoritesProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureUI()
        favTableView.register(FavTVC.self, forCellReuseIdentifier: FavTVC.identifier)
        
      
    }
    
    private func configureUI() {
        view.addSubview(favTableView)
        favTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}

//MARK: PresenterToViewFavoritesProtocol Methods
extension  FavoritesViewController :   PresenterToViewFavoritesProtocol  {
    func prepareTableView() {
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    
    func reloadTableView() {
        favTableView.reloadData()
    }
    
    func reloadIndexPath(indexPath: IndexPath) {
        favTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func sendMessage(text: String, isHidden: Bool) {
        favTableView.isHidden  = !isHidden
        messageLabel.isHidden = isHidden
        messageLabel.text = text
        
    }
}

//MARK: FavTVCDelegate Method
extension FavoritesViewController : FavTVCDelegate {
    func onTappedFavIcon(indexPath: IndexPath?) {
       
        guard let indexPath = indexPath else {return}
        
        presenter.onTappedFavIcon(indexPath: indexPath)
    }
}
