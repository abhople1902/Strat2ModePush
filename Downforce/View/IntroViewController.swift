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
        if let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            window.rootViewController = mainVC
            window.makeKeyAndVisible()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
