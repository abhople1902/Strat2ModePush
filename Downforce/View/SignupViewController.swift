//
//  SignupViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 26/04/25.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {

    
    @IBOutlet weak var mailInputOutlet: UITextField!
    @IBOutlet weak var passwordInputOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let emailEntered = mailInputOutlet.text, let passEntered = passwordInputOutlet.text {
            Auth.auth().createUser(withEmail: emailEntered, password: passEntered) { authResult, error in
                if let error = error {
                    print("Error creating user: \(error)")
                    return
                }
                print("User created!")
                self.performSegue(withIdentifier: "SignupSuccess", sender: self)
            }
        }
    }
    

}
