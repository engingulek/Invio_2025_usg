//
//  LabelFactory.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
enum LabelType {
    /// big label for screen
    case bannerTitleLabel
    /// normal label for screen
    case normalLabel
    /// error label
    case errorLabel
    /// big label for cell
    case cellTitleLabel
    /// normal label for cell
    case cellLabel( NSTextAlignment)
}

struct LabelFactory {
    static func createLabel(ofType type: LabelType) -> UILabel {
        let label = UILabel()
        label.numberOfLines = .zero
        switch type {
        case .bannerTitleLabel:
            label.font = .boldSystemFont(ofSize: 25)
            label.textColor = .black
            label.textAlignment = .center
        case .normalLabel:
            label.font = .systemFont(ofSize: 20)
            label.textColor = .black
            label.textAlignment = .center
        case .errorLabel:
            label.font = .boldSystemFont(ofSize: 25)
            label.textColor = .red
            label.textAlignment = .center
        case .cellTitleLabel:
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = .black
        case.cellLabel(let aligment):
            label.font = .boldSystemFont(ofSize: 15)
            label.textColor = .black
            label.textAlignment = aligment
            
        }
        return label
    }
}
