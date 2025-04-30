//
//  ViewControllerAbles.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

import UIKit

//MARK: - UIViewAble
/// This protocol sets the common viewcontroller content.
public protocol UIViewAble {
    func setBackColorAble(color:String)
}

extension UIViewAble where Self : UIViewController  {
    /// Sets the background color of the view according to the given hex color code
    public func setBackColorAble(color:String){
        view.backgroundColor = UIColor(hex:color)
    }
    
}

//MARK: - SegueAble
// Adjusting navigation between View Controllers
public protocol SegueAble {
    func pushViewControllerAble (_ vc:UIViewController,animated:Bool)

}

extension SegueAble  where Self : UIViewController{
    /// Pushviewcontroller between ViewControllers
    public func pushViewControllerAble (_ vc:UIViewController,animated:Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
}

//MARK: - NavConUIAble
/// Setting navigation controller contents
protocol NavConUIAble {
    /// Set navigation title
    func setNavigationTitle(title:String)
    /// set right button to navigation
    func setNavigationRightButton(iconImage:String,onTappedAction:Selector)
    /// hide state  back button
    func hidedBackAble(isHidden:Bool)
   
}

extension NavConUIAble where Self : UIViewController  {
    func setNavigationTitle(title:String) {
        navigationItem.title = title
    }
    
    func setNavigationRightButton(iconImage:String,onTappedAction:Selector) {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: iconImage),
                                          style: .plain, target: self, action: onTappedAction)
        rightButton.tintColor = UIColor(hex: ColorTheme.favColor.rawValue)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func hidedBackAble(isHidden:Bool) {
        navigationItem.hidesBackButton = isHidden
    }
}


//MARK: - AlertControllerAble
/// Aclert Message Action Button Info
struct ActionInfo {
    let title:String
    let action:()->Void
}

protocol AlertControllerAble {
    
    /// Creating a two-option alert message
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    ///   - positiveSection: positive button action info
    ///   - negationSection: negative button action info
    func createAlert(title:String,message:String,positiveSection:ActionInfo,negationSection:ActionInfo)
}

extension AlertControllerAble where Self : UIViewController   {
    func createAlert(title:String,message:String,positiveSection:ActionInfo,negationSection:ActionInfo) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let positiveAction = UIAlertAction(title: positiveSection.title, style: .default) { _ in
            positiveSection.action()
        }
        let negativeAction = UIAlertAction(title: negationSection.title, style: .cancel) { _ in
            negationSection.action()
        }
        
        alert.addAction(positiveAction)
        alert.addAction(negativeAction)
        self.present(alert, animated: true)
    }
}

