//
//  LoginViewController.swift
//  theMovieDB
//
//  Created by Pedro Carlos Monzalvo N on 09/05/22.
//

import UIKit

class LoginViewController: UIViewController{
    

    let buttonLog: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    var userTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.placeholder = "Please enter username"
        textField.backgroundColor = .white
        return textField
    }()
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .white
        textField.placeholder = "Please enter password"
        return textField
    }()
    let warringLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(buttonLog)
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        view.addSubview(warringLabel)
        buttonLog.addTarget(self, action: #selector(buttonLoggin), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let constraints =  [
            userTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            userTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: userTextField.topAnchor, constant: 55),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            buttonLog.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 65),
            buttonLog.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonLog.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonLog.heightAnchor.constraint(equalToConstant: 50),
            buttonLog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warringLabel.topAnchor.constraint(equalTo: buttonLog.topAnchor, constant: 60),
            warringLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            warringLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            warringLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func buttonLoggin(){
        guard let users = Client.parseJson(jsonName: "Users", model: UserModel.self) else { return print("Error al obtener Json")}
        
        guard let getUser = users.users?.filter({
                   $0.password == passwordTextField.text! &&
                   $0.user == userTextField.text!}).first else{ warringLabel.text = "Invalid username or password"
                   return
               }
        let mainView: UIViewController = HomeViewController()
        let navController = UINavigationController(rootViewController: mainView)
        
        navController.modalPresentationStyle = .fullScreen
        navController.setViewControllers([mainView], animated: false)
        present(navController, animated: true)
    }
}



