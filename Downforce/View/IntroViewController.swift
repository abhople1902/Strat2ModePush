//
//  IntroViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 01/04/25.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var stratTwoNewsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLogo()
    }
    
    
    func animateLogo() {
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.stratTwoNewsLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.stratTwoNewsLabel.alpha = 1
        }) { _ in
            self.navigateToNextScreen()
        }
    }
    
    func navigateToNextScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let authVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavController") as? UINavigationController {
            window.rootViewController = authVC
            window.makeKeyAndVisible()
        }
    }

}
