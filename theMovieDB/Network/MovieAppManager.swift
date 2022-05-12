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
    private let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    lazy var jsonDecoder = JSONDecoder()
    
    static let shared: MovieAppManager = MovieAppManager()
    
    enum MovieErrors: String {
        case mapError = "The Json not match with Moviemodel"
        case empyError = "The data is empty"
    }
    
    func getMovieList(finished: @escaping (MovieModel?, MovieErrors?) -> ()){
        let endpoint = "/movie/popular?"
        let params = "api_key=\(self.key)&language=\(self.lang)"
        guard let url = URL(string: baseUrl + endpoint + params) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data else {
                finished(nil, MovieErrors.empyError)
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
    
    func moviePosterFullPath(forMovie moviePath: String) -> String?  {
        guard !moviePath.isEmpty else { return nil }
            let size: String = "w200"
            return imageBaseUrl + size + moviePath
        }
}
