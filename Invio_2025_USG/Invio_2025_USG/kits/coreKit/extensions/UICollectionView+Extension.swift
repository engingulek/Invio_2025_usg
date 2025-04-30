//
//  UICollectionView+Extension.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit
//MARK: UICollectionView + Extension
extension UICollectionView {
    public static func primaryCollectionView(tag:Int = 0,
                                             scroolDirection:UICollectionView.ScrollDirection) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = scroolDirection
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = tag
        
        return collectionView
    }
}
