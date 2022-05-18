//
//  DetailModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 17/05/22.
//

import Foundation

struct DetailModel: Codable {
    var adult: Bool?
    var genres: [Genres]?
    var id: Int?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [Companies]?
    var release_date: String?
    var tagline: String?
    var title: String?
}


struct Genres: Codable {
    var id: Int?
    var name: String?
}

struct Companies: Codable, BrandCellModel {
    var cellImage: String {
        logo_path ?? ""
    }
    var name: String?
    var id: Int?
    var logo_path: String?
}



