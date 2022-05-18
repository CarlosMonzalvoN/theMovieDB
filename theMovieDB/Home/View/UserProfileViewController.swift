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
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .white
        return label
    }()
    let email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = .white
        return label
    }()
    let userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 80
        return image
    }()
    
    let exitButton: UIButton = UIButton(type: .system)
    private var blurEffectView: UIVisualEffectView?
    private var navigation: UINavigationController?
    
    init(with navigation: UINavigationController) {
        super.init(nibName: nil, bundle: nil)
        self.navigation =  navigation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        let config: UserViewModel = UserViewConfig()
        view.backgroundColor = .clear
        view.addSubviewIfAble(userName)
        view.addSubviewIfAble(email)
        view.addSubviewIfAble(userImage)
        view.addSubviewIfAble(exitButton)
        configureButton()
        configure(model: config)
        configureConstraints()
    }
    
    private func configure(model: UserViewModel){
        userName.text = model.usernameText
        email.text = model.emailText
        userImage.image = UIImage(named: model.userImage)
    }
    
    func configureButton() {
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitle("Log Out", for: .normal)
        exitButton.backgroundColor = .red
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut(){
        self.dismiss(animated: true) { [weak self] in
            self?.navigation?.dismiss(animated: true)
        }
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 160),
            userImage.heightAnchor.constraint(equalToConstant: 160),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 16),
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            email.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5),
            email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            email.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func addBackground() {
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubviewIfAble(blurEffectView)
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
