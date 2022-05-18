//
//  DetailsViewModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 17/05/22.
//

import Foundation
import UIKit

protocol DetailsViewModel: NSObject{
    
    var imageUrl: String? { get }
    var titleMovie: String? { get }
    var overviewMovie: String? { get }
    var rating: String? { get }
    var logoCompanies: [String]? { get }
    var taglineMovie: String? { get }
    var adultClassification: String? { get }
    var genreMovie: String? { get }
    
    func getDataDetails(movie id: Int?, completion: @escaping () -> ())
    func getDetailsWithExistingId(completion: @escaping () -> ())
}

class DetailMovieCofiguration: NSObject, DetailsViewModel, UICollectionViewDataSource {
    var imageUrl: String? {
        model?.poster_path
    }
    var titleMovie: String? {
        model?.title
    }
    var overviewMovie: String? {
        model?.overview
    }
    var rating: String? {
        String(format: "%.2f", ((model?.popularity ?? 1000) / 1000))
    }
    var logoCompanies: [String]? {
        model?.production_companies?.map({
            $0.logo_path ?? ""
        })
    }
    var taglineMovie: String? {
        model?.tagline
    }
    var adultClassification: String? {
        if (model?.adult ?? false) {
             return "Only Adult"
        } else {
            return "Family Friendly"
        }
    }
    var genreMovie: String? {
        var text: String = "| "
        model?.genres?.forEach({
            text += ($0.name ?? "") + " | "
        })
        return text
    }
    private var model: DetailModel?
    var idmoview: Int
    
    init(id: Int) {
        self.idmoview = id
    }
    
    func getDetailsWithExistingId(completion: @escaping () -> ()){
        self.getDataDetails(movie: idmoview, completion: completion)
    }
    
    func getDataDetails(movie id: Int?, completion: @escaping () -> ()){
        let manager = MovieAppManager.shared
        let idmovie = id ?? 0
        
        manager.getMovieDetail(movie: idmovie) { [weak self] movieDetail, error in
            let successfull: Bool = (error == nil) && (movieDetail != nil)
            guard successfull, let model = movieDetail else {
                completion()
                return
            }
            self?.model = model
            completion()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.production_companies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reusableIdentifier, for: indexPath)
        if let currentCell = cell as? BrandCell,
            let brand = model?.production_companies![indexPath.row]
        {
            currentCell.configure(with: brand)
        }
        return cell
    }
    
}


