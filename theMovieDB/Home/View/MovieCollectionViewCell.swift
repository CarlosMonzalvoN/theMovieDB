//
//  MovieCell.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 11/05/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var backgroundImageView: UIImageView = {
        let backgroundcell = UIImageView()
        backgroundcell.translatesAutoresizingMaskIntoConstraints = false
        backgroundcell.contentMode = .scaleAspectFill
        backgroundcell.clipsToBounds = true
        backgroundcell.layer.cornerRadius = 14
        return backgroundcell
    }()
    
    var titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var overviewMovieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    func configure(model: MovieViewModel) {
        backgroundImageView.loadFrom(URLAddress: model.posterUrl)
        titleMovieLabel.text = model.titleText
        overviewMovieLabel.text = model.overviewText
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.cornerRadius = 14
        contentView.backgroundColor = .gray
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleMovieLabel)
        contentView.addSubview(overviewMovieLabel)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 170),
            titleMovieLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            titleMovieLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleMovieLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            titleMovieLabel.heightAnchor.constraint(equalToConstant: 40),
            overviewMovieLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor),
            overviewMovieLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            overviewMovieLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            overviewMovieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
