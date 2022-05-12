//
//  UserManager.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import Foundation

class UserManager{
    var user: Users?
    static let shared: UserManager = UserManager()
    
    func setUser(user: Users) {
        self.user = user
        let keychain: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrLabel as String: user.email,
            kSecAttrAccount as String: user.user,
            kSecValueData as String: user.password
        ]
        SecItemAdd(keychain as CFDictionary, nil)
    }
    
    func getUser() -> UserViewModel? {
        return user as? UserViewModel
    }
}

extension Users: UserViewModel{
    var usernameText: String {
        self.user
    }
    
    var emailText: String {
        self.email
    }
    
    var userImage: String {
        "user_logo"
    }
    
    
}
