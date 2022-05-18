//
//  MovieModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 11/05/22.
//

import Foundation


struct MovieModel: Codable {
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
}

struct Movie: Codable {
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var id: Int?
    var original_title: String?
    var title: String?
}

extension Movie: MovieViewModel {
    var posterUrl: String {
        poster_path ?? ""
    }
    
    var titleText: String {
        title ?? ""
    }
    
    var overviewText: String {
        overview ?? ""
    }
    
    
}
