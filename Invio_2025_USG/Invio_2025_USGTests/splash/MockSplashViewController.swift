//
//  MockSplashViewController.swift
//  Invio_2025_USGTests
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
@testable import Invio_2025_USG

class MockSplashViewController : PresenterToViewSplashProtocol {
    
    var invokedsetBackColorAble:Bool = false
    var invokedsetBackColorAbleCount:Int = 0
    var invokedsetBackColorAbleData = [(color:String,Void)]()
    func setBackColorAble(color: String) {
        invokedsetBackColorAble = true
        invokedsetBackColorAbleCount += 1
        invokedsetBackColorAbleData.append((color:color,()))
    }
    
    var invokedSendTitle:Bool = false
    var invokedSendTitleCount:Int = 0
    var invokedSendTitleData = [(title:String,isHidden:Bool)]()
    func sendTitle(title: String, isHidden: Bool) {
        invokedSendTitle = true
        invokedSendTitleCount += 1
        invokedSendTitleData.append((title: title, isHidden: isHidden))
    }
    
    var invokedSendErrorMessage:Bool = false
    var invokedSendErrorMessageCount:Int = 0
    var invokedSendErrorMessageData = [(text:String,isHidden:Bool)]()
    func sendErrorMessage(text: String, isHidden: Bool) {
        invokedSendErrorMessage = true
        invokedSendErrorMessageCount += 1
        invokedSendErrorMessageData.append((text: text, isHidden: isHidden))
    }
    
    var invokedpushViewControllerAble:Bool = false
    var invoedkpushViewControllerAblecCount:Int = 0
    func pushViewControllerAble(_ vc: UIViewController, animated: Bool) {
        invokedpushViewControllerAble = true
        invoedkpushViewControllerAblecCount += 1
    }
}
