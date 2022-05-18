//
//  DetailMovieViewController.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 17/05/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var imageMovie = UIImageView()
    private var titleLabel = UILabel()
    private var popularityLabel = UILabel()
    private var genreLabel = UILabel()
    private var rateLabel = UILabel()
    private var taglineLabel = UILabel()
    private var overviewLabel = UILabel()
    private var imagesCompanies: [UIImageView] = []
    private var blurEffectView: UIVisualEffectView?
    private var model: DetailsViewModel
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        view.addSubviewIfAble(imageMovie)
        view.addSubviewIfAble(titleLabel)
        view.addSubviewIfAble(popularityLabel)
        view.addSubviewIfAble(genreLabel)
        view.addSubviewIfAble(rateLabel)
        view.addSubviewIfAble(taglineLabel)
        view.addSubviewIfAble(overviewLabel)
        view.addSubviewIfAble(collectionView)
        constrains()
        configureObjects()
        configure(model: model)
        bind()
        collectionView.delegate = self
        guard let datasource = model as? UICollectionViewDataSource else
        {
            return
        }
        collectionView.dataSource = datasource
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.reusableIdentifier)
    }
    
    private func bind(){
        model.getDetailsWithExistingId(completion: { [weak self] in
            guard let self = self else { return }
            self.configure(model: self.model)
        })
    }
    
    init(withModel model: DetailsViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("No model was supplied")
    }
    
    func configure(model: DetailsViewModel) {
        imageMovie.loadFrom(URLAddress: model.imageUrl ?? "", usingbaseurl: true, size: .poster)
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = model.titleMovie
            self?.popularityLabel.text = model.rating
            self?.genreLabel.text = model.genreMovie
            self?.rateLabel.text = model.adultClassification
            self?.overviewLabel.text = model.overviewMovie
            self?.taglineLabel.text = model.taglineMovie
            self?.collectionView.reloadData()
        }
    }
    
    func configureObjects() {
        imageMovie.contentMode = .scaleAspectFill
        imageMovie.clipsToBounds = true
        imageMovie.layer.cornerRadius = 14
        //Title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        //Popularity
        popularityLabel.textColor = .white
        popularityLabel.textAlignment = .right
        popularityLabel.numberOfLines = 1
        popularityLabel.font = UIFont.systemFont(ofSize: 14)
        //Genre
        genreLabel.textColor = .white
        genreLabel.textAlignment = .left
        genreLabel.numberOfLines = 1
        genreLabel.font = UIFont.systemFont(ofSize: 14)
        //rate
        rateLabel.textColor = .white
        rateLabel.textAlignment = .left
        rateLabel.numberOfLines = 1
        rateLabel.font = UIFont.systemFont(ofSize: 14)
        //Tagline
        taglineLabel.textColor = .white
        taglineLabel.textAlignment = .left
        taglineLabel.numberOfLines = 1
        taglineLabel.font = UIFont.systemFont(ofSize: 14)
        //OverView
        overviewLabel.textColor = .white
        overviewLabel.textAlignment = .justified
        overviewLabel.numberOfLines = 5
        overviewLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    func constrains(){
        
        imageMovie.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMovie.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageMovie.widthAnchor.constraint(equalToConstant: 180),
            imageMovie.heightAnchor.constraint(equalToConstant: 250),
            titleLabel.topAnchor.constraint(equalTo: imageMovie.bottomAnchor, constant: 14),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            popularityLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 10),
            popularityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            popularityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            rateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            rateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            taglineLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 10),
            taglineLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            taglineLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            overviewLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 10),
            overviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            overviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func addBackground() {
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubviewIfAble(blurEffectView)
    }
    
    private func addImageViews() {
        imagesCompanies.forEach({
            if $0.superview == nil {
                view.addSubviewIfAble($0)
            }
        })
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    
}
