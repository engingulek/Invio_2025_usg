//
//  BaseView.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit

open class BaseView<T: UIViewController>: UIView {
   public weak var controller: T?
    
   public init(_ controller: T) {
        self.controller = controller
        super.init(frame: .zero)
        
        setupView()
    }
    
   open func setupView() { }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

