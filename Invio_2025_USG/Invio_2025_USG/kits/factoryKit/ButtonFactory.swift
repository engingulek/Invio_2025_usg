//
//  ButtonFactory.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

//MARK : - ButtonType
enum ButtonType {
    /// basic button -> action
    case basic(action:UIAction)
    /// button with icon
    /// icon: -> icon type
    /// action -> button action
    /// color -> tint color
    /// backColor: -> background color => default .primary color
    case iconButton(icon:IconTheme,action:UIAction,color:ColorTheme,backColor:ColorTheme = .primaryColor)
}

//MARK: - ButtonFactory
struct ButtonFactory {
    static func createButton(ofType type: ButtonType) -> UIButton {
        let button = UIButton()
        switch type {
        case .basic(let action):
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.addAction(action, for: .touchUpInside)
            button.backgroundColor = UIColor(hex: ColorTheme.secondaryColor.rawValue)
            button.titleLabel?.textColor = .white
        case .iconButton(let icon, let action, let color, let backColor):
            let image = UIImage(systemName: icon.rawValue)
            button.setImage(image, for: .normal)
            button.tintColor = UIColor(hex: color.rawValue)
            button.backgroundColor = UIColor(hex: backColor.rawValue)
            button.addAction(action, for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFill
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
         
        }
        return button
    }
}
