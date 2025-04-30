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
