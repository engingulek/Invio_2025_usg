//
//  HomeVC+UITableView.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

import UIKit

//MARK: -  HomeViewController: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTVC.identifier, for: indexPath) as? LocationTVC
        else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath = indexPath
        cell.isUserInteractionEnabled = true
        
        let item = presenter.cellForItem(at: indexPath)
        cell.configureData(locationName: item.element.name, favState: item.favState)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cityHeaderSection = CityHeaderViewOnTVC()
        let item = presenter.viewForHeader(in: section)
        cityHeaderSection.configureData(title: item.element.city, type: item.expendType, section: section)
        cityHeaderSection.delegate = self
        return cityHeaderSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.heightForHeaderInSection()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spinner = UIActivityIndicatorView.baseActivityIndicator()
        spinner.startAnimating()
        return spinner
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return presenter.isLoading ? 50 : 0
    }
}

//MARK: - HomeViewController: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight * 1.5) && !presenter.isLoading {
            presenter.scrollViewDidEnd()
        }
    }
}

