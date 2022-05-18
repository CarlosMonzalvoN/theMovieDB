//
//  BrandCellModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 18/05/22.
//

import UIKit

protocol BrandCellModel{
    var cellImage: String { get }
}

class BrandCell: UICollectionViewCell {
    static let reusableIdentifier: String = String.init(describing: BrandCell.self)
    private var imageView: UIImageView = UIImageView()
    
    func configure(with model: BrandCellModel) {
        configureUI()
        imageView.loadFrom(URLAddress: model.cellImage, usingbaseurl: true, size: .thumbnail, withTint: true)
    }
    
    private func configureUI() {
        imageView.removeFromSuperview()
        self.addSubviewIfAble(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
