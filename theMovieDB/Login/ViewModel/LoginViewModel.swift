//
//  LoginViewModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import Foundation

protocol LoginViewModel{
    var userLabelPlaceholder: String { get }
    var passwordLabelPlaceholder: String { get }
    var buttonLoginText: String { get }
    var logoImage: String { get }
}
