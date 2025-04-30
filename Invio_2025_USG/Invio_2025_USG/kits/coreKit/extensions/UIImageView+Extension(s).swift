//
//  UIImageView+Extension(s).swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation
import UIKit.UIImageView
import Kingfisher

//MARK: UIImageView + Extension
extension UIImageView {
    // Display image with url using kingfisher
    /// - Parameters:
    ///   - urlString: image url
    ///   - size: image size
    func setImageWithKigfisher(with urlString: String?,size:Int = 100) {
        guard let url = URL(string: urlString ?? "") else {
            self.image = UIImage(resource: .placePlaceholder)
            return
        }
       let resizingProcessor = ResizingImageProcessor(
        referenceSize: CGSize(width: size, height: size), mode: .aspectFill)
        self.kf.setImage(
            with: url,
            placeholder: UIImage(resource: .placePlaceholder),
            options: [
                .processor(resizingProcessor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .cacheOriginalImage,
                .memoryCacheExpiration(.seconds(1)),
                .diskCacheExpiration(.days(7))
                
            ],
            progressBlock: nil,
            completionHandler: {  _ in
                
            }
        )
    }
}
