//
//  UserProfile.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 12/05/22.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 80
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config: UserViewModel = UserViewConfig()
        view.backgroundColor = .white
        view.addSubview(userName)
        view.addSubview(email)
        view.addSubview(userImage)
        configure(model: config)
        configureConstraints()
    }
    
    private func configure(model: UserViewModel){
        userName.text = model.usernameText
        email.text = model.emailText
        userImage.image = UIImage(named: model.userImage)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 160),
            userImage.heightAnchor.constraint(equalToConstant: 160),
            userImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            userName.heightAnchor.constraint(equalToConstant: 50),
            userName.widthAnchor.constraint(equalToConstant: 70),
            email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            email.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            email.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            email.heightAnchor.constraint(equalToConstant: 50),
            email.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

struct UserViewConfig: UserViewModel {
    
    let manager = UserManager.shared
    
    var usernameText: String{
        manager.user?.user ?? "Usuario"
    }
    var emailText: String {
        manager.user?.email ?? "Correo"
    }
    var userImage: String {
        manager.user?.userImage ?? "user_logo"
    }
    
    
}
