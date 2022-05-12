//
//  UserViewModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import Foundation

protocol UserViewModel{
    var usernameText: String { get }
    var emailText: String { get }
    var userImage: String { get }
}
