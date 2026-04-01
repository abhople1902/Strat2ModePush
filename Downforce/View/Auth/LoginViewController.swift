//
//  LoginViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 26/04/25.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.font = UIFont(name: "Impact", size: 38) ?? UIFont.systemFont(ofSize: 38, weight: .regular)
        label.textAlignment = .left
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

//    private let accessoryTextField: UITextField = {
//        let field = UITextField()
//        field.borderStyle = .roundedRect
//        field.backgroundColor = .clear
//        field.autocapitalizationType = .none
//        field.autocorrectionType = .no
//        field.clearButtonMode = .whileEditing
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()

//    private weak var activeFormField: UITextField?

    private lazy var dismissKeyboardTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        return gesture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hosting = UIHostingController(rootView: SigninView().ignoresSafeArea(.keyboard))
        
        addChild(hosting)
        hosting.view.frame = view.bounds
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hosting.view)
        
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hosting.didMove(toParent: self)
        view.sendSubviewToBack(hosting.view)
        
        
        
        view.addSubview(titlelabel)
        view.addSubview(emailField)
        view.addSubview(passField)
        view.addSubview(loginButton)
        view.backgroundColor = .clear
        
        emailField.delegate = self
        passField.delegate = self
//        accessoryTextField.delegate = self

//        emailField.inputAccessoryView = inputContainerView
//        passField.inputAccessoryView = inputContainerView

        setUpConstraints()
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        view.addGestureRecognizer(dismissKeyboardTapGesture)
    }
    
//    lazy var inputContainerView: UIView = {
//        let containerView = UIView()
//        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
//        containerView.backgroundColor = UIColor.systemGray6
//
//        containerView.addSubview(accessoryTextField)
//        NSLayoutConstraint.activate([
//            accessoryTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
//            accessoryTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
//            accessoryTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
//            accessoryTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
//        ])
//
//        accessoryTextField.addTarget(self, action: #selector(accessoryTextChanged), for: .editingChanged)
//        return containerView
//    }()
    
//    override var inputAccessoryView: UIView? {
//        get {
//            return inputContainerView
//        }
//    }
    
//    override var canBecomeFirstResponder: Bool {
//        return true
//    }
    
    
    @objc private func handleLogin() {
        dismissKeyboard()
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
                if let email = authResult?.user.email {
                    UserDefaults.standard.set(email, forKey: "loggedInEmail")
                }
                strongSelf.navigateToNextScreenOnLogin()
//                strongSelf.performSegue(withIdentifier: "LoginSuccess", sender: self)
            }
        }
        
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

//    @objc private func accessoryTextChanged() {
//        activeFormField?.text = accessoryTextField.text
//    }

//    private func configureAccessoryField(for textField: UITextField) {
//        activeFormField = textField
//        accessoryTextField.text = textField.text
//        accessoryTextField.placeholder = textField.placeholder
//        accessoryTextField.keyboardType = textField.keyboardType
//        accessoryTextField.isSecureTextEntry = textField.isSecureTextEntry
//        accessoryTextField.returnKeyType = textField == emailField ? .next : .done
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == accessoryTextField {
//            return
//        }
//        configureAccessoryField(for: textField)
//    }

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//        if textField == emailField || textField == passField {
//            activeFormField = textField
//            accessoryTextField.text = updatedText
//        } else if textField == accessoryTextField {
//            activeFormField?.text = updatedText
//        }
//
//        return true
//    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passField.becomeFirstResponder()
        }
//        else if textField == accessoryTextField {
//            if activeFormField == emailField {
//                passField.becomeFirstResponder()
//            } else {
//                textField.resignFirstResponder()
//            }
//        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    
    func navigateToNextScreenOnLogin() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let authVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController {
            window.rootViewController = authVC
            window.makeKeyAndVisible()
        }
    }
    
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titlelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titlelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 26),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            passField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 26),
            passField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -240),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 26)
        ])
        
        
    }

}
