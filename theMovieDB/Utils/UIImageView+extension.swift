//
//  UIImageView+extension.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 11/05/22.
//

import UIKit

extension UIImageView {
    
    enum Size: String {
    case thumbnail = "w200"
    case poster = "w500"
    case unknown = ""
    }
    
    
    func loadFrom(URLAddress: String, usingbaseurl: Bool = false, size: Size = .unknown, withTint: Bool = false) {
        let urlString: String = usingbaseurl ? (baseUrl + size.rawValue + URLAddress) : size.rawValue + URLAddress
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    if withTint {
                        self?.loadWithTint(image: loadedImage)
                    } else {
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
    
    func loadWithTint(image: UIImage) {
        self.tintColor = .white
        self.image = image.withRenderingMode(.alwaysTemplate)
    }
}
