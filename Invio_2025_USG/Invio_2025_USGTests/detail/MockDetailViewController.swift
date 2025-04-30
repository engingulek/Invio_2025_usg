//
//  MockDetailViewController.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
@testable import Invio_2025_USG

class MockDetailViewController : PresenterToViewDetailProtocol {
   
   
    
    var invokedSetNavigationTitle = false
    var invokedSetNavigationTitleCount = 0
    var invokedSetNavigationTitleParameters = [(title:String,Void)]()
    func setNavigationTitle(title: String) {
        invokedSetNavigationTitle = true
        invokedSetNavigationTitleCount += 1
        invokedSetNavigationTitleParameters.append((title: title, ()))
    }

    
    var invokedSetNavigationRightButton = false
    var invokedSetNavigationRightButtonCount = 0
    var invokedSetNavigationRightButtonParameters = [(iconImage: String, onTappedAction: Selector)]()
    func setNavigationRightButton(iconImage: String, onTappedAction: Selector) {
        invokedSetNavigationRightButton = true
        invokedSetNavigationRightButtonCount += 1
        invokedSetNavigationRightButtonParameters.append((iconImage: iconImage, onTappedAction: onTappedAction))
    }
    
    var invokedHidedBackAble = false
    var invokedHidedBackAbleCount = 0
    var invokedHidedBackAbleParameters = [(isHidden:Bool,Void)]()
    func hidedBackAble(isHidden: Bool) {
        invokedHidedBackAble = true
        invokedHidedBackAbleCount += 1
        invokedHidedBackAbleParameters.append((isHidden: isHidden, ()))
    }
    
    var invokedpushViewControllerAble:Bool = false
    var invoedkpushViewControllerAblecCount:Int = 0
    func pushViewControllerAble(_ vc: UIViewController, animated: Bool) {
        invokedpushViewControllerAble = true
        invoedkpushViewControllerAblecCount += 1
    }
    
    var invokedsetBackColorAble:Bool = false
    var invokedsetBackColorAbleCount:Int = 0
    var invokedsetBackColorAbleData = [(color:String,Void)]()
    func setBackColorAble(color: String) {
        invokedsetBackColorAble = true
        invokedsetBackColorAbleCount += 1
        invokedsetBackColorAbleData.append((color:color,()))
    }
    
    
    func sendDetailInfo(imageUrl: String?, detail: String) {
        
    }
    
    func sendErrorMessage(text: String, isHidden: Bool) {
        
    }
    
    
}

