//
//  ViewController.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 09/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var model: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = HomeViewConfiguration(with: self)
        view.backgroundColor = .white
        configureNavigationBar()
        configureCollectionView()
        configure()
    }
    
    private func configure() {
        title = model?.title
        model?.getData()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func addTapped(){
        guard let navigation = self.navigationController else {  return }
        let controller: UIViewController = UserProfileViewController(with: navigation)
        modalPresentationStyle = .popover
        present(controller, animated: true, completion: nil)
    }
    
    private func configureCollectionView() {
        collectionView?.removeFromSuperview()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .black
        view.addSubviewIfAble(collectionView)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
        ])
    }
    
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.cellCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        if let currentCell = cell as? MovieCollectionViewCell,
           let movie = model?.getMovie(for: indexPath.item) as? MovieViewModel {
            currentCell.configure(model: movie)
        }
        return cell
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.2, height: collectionView.frame.width/1.2)
    }
}
extension HomeViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = model?.getMovie(for: indexPath.item),
              let movieid = movie.id else {
            return
        }
        let configuration: DetailsViewModel = DetailMovieCofiguration(id: movieid)
        let controller: UIViewController = MovieDetailViewController.init(withModel: configuration)
        modalPresentationStyle = .popover
        present(controller, animated: true, completion: nil)
        
    }
}
