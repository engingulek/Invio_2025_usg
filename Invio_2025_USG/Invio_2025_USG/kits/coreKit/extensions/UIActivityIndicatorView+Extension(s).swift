//
//  UIActivityIndicatorView+Extension(s).swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
// MARK: - UIActivityIndicatorView Extension
/// An extension for `UIActivityIndicatorView` to provide a custom base activity indicator.
extension UIActivityIndicatorView {
    static public func baseActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        indicator.style = .large
        return indicator
    }
}
