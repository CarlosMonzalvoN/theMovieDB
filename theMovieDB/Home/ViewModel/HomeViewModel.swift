//
//  HomeViewModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import Foundation

protocol HomeViewModel{
    var movies: MovieModel { get set }
    var title: String { get set }
    var view: HomeViewController? { get set }
    var cellCount: Int { get }
    func getMovie(for index: Int) -> Movie?
    func getData()
}

class HomeViewConfiguration: HomeViewModel {
    weak var view: HomeViewController?
    var movies = MovieModel()
    var title: String = "Movies"
    var cellCount: Int {
        movies.results?.count ?? 0
    }
    
    init(with view: HomeViewController) {
        self.view = view
    }
    
    func getData() {
        let manager = MovieAppManager.shared
        manager.getMovieList { [weak self] movieData, error in
            guard error == nil else {
                return
            }
            self?.movies = movieData ?? MovieModel()
            self?.view?.reloadData()
        }
    }
    
    func getMovie(for index: Int) -> Movie? {
        movies.results?[index]
    }
}
