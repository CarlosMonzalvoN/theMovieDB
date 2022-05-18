//
//  MovieAppManager.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 11/05/22.
//

import UIKit


class MovieAppManager{
    private let key = "5aa9f9d04ab72a31b70f56ef9db4b81e"
    private let lang = "en-US"
    private let baseUrl = "https://api.themoviedb.org/3"
    fileprivate let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    lazy var jsonDecoder = JSONDecoder()
    
    static let shared: MovieAppManager = MovieAppManager()
    
    enum MovieErrors: String {
        case mapError = "The Json not match with Moviemodel"
        case emptyError = "The data is empty"
    }
    
    enum DetailMovieErrors: String {
        case mapError = "The Json not match with Moviemodel"
        case emptyError = "The data is empty"
    }
    
    func getMovieList(finished: @escaping (MovieModel?, MovieErrors?) -> ()) {
        let endpoint = "/movie/popular?"
        let params = "api_key=\(self.key)&language=\(self.lang)"
        guard let url = URL(string: baseUrl + endpoint + params) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data else {
                finished(nil, MovieErrors.emptyError)
                return
            }
            let decoder = JSONDecoder()
            let movieData: MovieModel? = try? decoder.decode(MovieModel.self, from: json)
            guard let movies =  movieData else {
                finished(nil, MovieErrors.mapError)
                return
            }
            finished(movies, nil)
        }.resume()
    }
    
    func getMovieDetail(movie id: Int, finished: @escaping (DetailModel?, DetailMovieErrors?) -> ()) {
        let endpoint = "/movie"
        let idmovie = "/\(id)?"
        let params = "api_key=\(self.key)&language=\(self.lang)"
        guard let url = URL(string: baseUrl + endpoint + idmovie + params) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data else {
                finished(nil, DetailMovieErrors.emptyError)
                return
            }
            let decoder = JSONDecoder()
            let detailMovieData: DetailModel? = try? decoder.decode(DetailModel.self, from: json)
            guard let detailsMovie =  detailMovieData else {
                finished(nil, DetailMovieErrors.mapError)
                return
            }
            finished(detailsMovie, nil)
        }.resume()
    }
    
}

extension UIImageView {
    var baseUrl: String {
        MovieAppManager.shared.imageBaseUrl
    }
}
