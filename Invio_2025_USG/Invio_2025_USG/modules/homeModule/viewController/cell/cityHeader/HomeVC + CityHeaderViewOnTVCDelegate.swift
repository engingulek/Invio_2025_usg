//
//  HomeVC + CityHeaderViewOnTVCDelegate.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

extension HomeViewController : CityHeaderViewOnTVCDelegate {

    
    func sectionOnTapped(_ sectionIndex: Int) {
        presenter.onTappedSection(sectionIndex: sectionIndex)
    }
    
    func onTappedRightArrow(_ sectionIndex: Int) {
        presenter.onTappedRightArrow(sectionIndex: sectionIndex)
    }
}
