//
//  LoginViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 26/04/25.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.font = UIFont(name: "Verdana-Bold", size: 33)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.allowsEditingTextAttributes = false
        field.clearButtonMode = .whileEditing
        field.borderStyle = .roundedRect
        field.keyboardType = .emailAddress
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.keyboardType = .default
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.background.backgroundColor = .systemGray2
        config.baseForegroundColor = .black
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titlelabel)
        view.addSubview(emailField)
        view.addSubview(passField)
        view.addSubview(loginButton)
        
        setUpConstraints()
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {
        if let emailEntered = emailField.text, let passEntered = passField.text {
            Auth.auth().signIn(withEmail: emailEntered, password: passEntered) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                
                if let error = error {
                    let alert = UIAlertController(title: "Unable to Login", message: "Youe email or password is incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    strongSelf.present(alert, animated: true)
                    print("Failed to login: \(error.localizedDescription)")
                    return
                }
                print("Logged in user: \(String(describing: authResult?.user.email))")
                strongSelf.performSegue(withIdentifier: "LoginSuccess", sender: self)
            }
        }
        
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 195)
        ])
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 41),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 58),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -59)
        ])
        
        NSLayoutConstraint.activate([
            passField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 39),
            passField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 58),
            passField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -59)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -405),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140)
//            loginButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 29)
        ])
        
        
    }

}
