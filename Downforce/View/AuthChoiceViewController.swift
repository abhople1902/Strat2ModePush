//
//  AuthChoiceViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 26/04/25.
//

import UIKit

class AuthChoiceViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "AuthWelcomeBack")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.8
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    private let welcomeText: UILabel = {
        let label = UILabel()
        label.text = "Strat 2 - Stay on top"
        label.textColor = .white
        label.font = UIFont(name: "Verdana", size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Login with email", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Register with email", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        view.addSubview(welcomeText)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        setUpConstraints()
        addTargets()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            welcomeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeText.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            signupButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }
    
    private func addTargets() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
    }
    @objc private func loginTapped() {
        self.performSegue(withIdentifier: "GoToLoginView", sender: self)
    }
    @objc private func signupTapped() {
        self.performSegue(withIdentifier: "GoToSignupView", sender: self)
    }
}


extension AuthChoiceViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GoToLoginView" {
//            
//        }
//    }
}
