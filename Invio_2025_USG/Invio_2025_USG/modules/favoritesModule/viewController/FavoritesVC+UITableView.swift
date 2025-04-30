//
//  FavoritesVC+UITableView.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

import UIKit

//MARK:  UITableViewDataSource,UITableViewDelegate Methods for FavoritesViewController
extension FavoritesViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavTVC.identifier, for: indexPath) as? FavTVC else {

            return UITableViewCell()
        }
        cell.indexPath = indexPath
        let item = presenter.cellForItem(at: indexPath)
        cell.textLabel?.text = item
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
    
}
