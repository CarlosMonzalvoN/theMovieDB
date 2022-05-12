//
//  UserModel.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 10/05/22.
//

import Foundation


struct UserModel : Decodable{
    let users : [Users]?
    
    struct Users : Decodable{
        let id : String
        let user : String
        let email : String
        let password : String
    }
}

