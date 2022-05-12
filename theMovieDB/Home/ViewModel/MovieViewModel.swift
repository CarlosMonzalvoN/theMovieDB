//
//  HomeViewModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import Foundation

protocol MovieViewModel {
    var posterUrl: String { get }
    var titleText: String { get }
    var overviewText: String { get }

}
