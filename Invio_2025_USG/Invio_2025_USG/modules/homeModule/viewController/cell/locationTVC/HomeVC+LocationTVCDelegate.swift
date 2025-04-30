//
//  HomeVC+LocationTVCDelegate.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

extension HomeViewController : LocationTVCDelegate {
    func onTappedFavIcon(indexPath: IndexPath?) {
        guard let indexPath = indexPath else {return}
      
        self.presenter.onTappedFavIconOnCell(indexPath: indexPath)
    }
}
