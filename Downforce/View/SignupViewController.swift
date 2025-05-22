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
                print("User created in firebase!")
                self.performSegue(withIdentifier: "SignupSuccess", sender: self)
            }
            guard let email = self.mailInputOutlet.text else { return }
            guard let pass = self.passwordInputOutlet.text else { return }
            let url = URL(string: "http://192.168.29.4:3000/api/auth/register")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "email": email,
                "password": pass,
                "name": "HARDCODED"
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Failed to encode body: \(error)")
                return
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Failed to register user in MongoDB: \(error)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    print("Unexpected status code from backend: \(httpResponse.statusCode)")
                    return
                }
                print("Successfully registered user in MongoDB.")
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "SignupSuccess", sender: self)
                }
            }.resume()
        }
    }
    

}
