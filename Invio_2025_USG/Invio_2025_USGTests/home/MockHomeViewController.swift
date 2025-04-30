//
//  MockHomeViewController.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
@testable import Invio_2025_USG
class MockHomeViewController : PresenterToViewHomeProtocol {
    
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0
    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }
    
    var invokedReloadIndexPath = false
    var invokedReloadIndexPathCount = 0
    var invokedReloadIndexPathData = [(indexPath:IndexPath,Void)]()
    func reloadIndexPath(indexPath: IndexPath) {
        invokedReloadIndexPath = true
        invokedReloadIndexPathCount += 1
        invokedReloadIndexPathData.append((indexPath: indexPath, ()))
    }
    
    var invokedReloadSection = false
    var invokedReloadSectionCount = 0
    var invokedReloadSectionData = [(index:Int,Void)]()
    func reloadSection(index: Int) {
        invokedReloadSection = true
        invokedReloadSectionCount += 1
        invokedReloadSectionData.append((index: index, ()))
    }
    
    var invokedCityCountText = false
    var invokedCityCountTextCount = 0
    var invokedCityCountTextData = [(text: String, count: Int, isHidden: Bool)]()
    func cityCountText(text: String, count: Int, isHidden: Bool) {
         invokedCityCountText = true
         invokedCityCountTextCount += 1
        invokedCityCountTextData.append((text: text, count: count, isHidden: isHidden))
    }
    
   
    var invokedSendError = false
    var invokedSendErrorCount = 0
    var invokedSendErrorParameters = [(text: String, isHidden: Bool)]()
    func sendError(text: String, isHidden: Bool) {
        invokedSendError = true
        invokedSendErrorCount += 1
        invokedSendErrorParameters.append((text: text, isHidden: isHidden))
    }

   
    var invokedCollapseButtonIsHidden = false
    var invokedCollapseButtonIsHiddenCount = 0
    var invokedCollapseButtonIsHiddenParameters = [(isHided:Bool,Void)]()
    func collapseButtonIsHidden(isHidden: Bool) {
        invokedCollapseButtonIsHidden = true
        invokedCollapseButtonIsHiddenCount += 1
        invokedCollapseButtonIsHiddenParameters.append((isHided: isHidden, ()))
    }

    
    var invokedCreateAlert = false
    var invokedCreateAlertCount = 0
    var invokedCreateAlertParameters = [(title: String, message: String, positive: Invio_2025_USG.ActionInfo, negative: Invio_2025_USG.ActionInfo)]()
    func createAlert(title: String, message: String, positiveSection: Invio_2025_USG.ActionInfo, negationSection: Invio_2025_USG.ActionInfo) {
        invokedCreateAlert = true
        invokedCreateAlertCount += 1
        invokedCreateAlertParameters.append((title: title, message: message, positive: positiveSection, negative: negationSection))
    }

   
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
}
