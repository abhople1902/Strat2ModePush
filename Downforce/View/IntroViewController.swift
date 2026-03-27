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
            if let _ = UserDefaults.standard.string(forKey: "loggedInEmail") {
                self.navigateToHomeDirectly()
                return
            } else {
                self.navigateToNextScreen()
            }
        }
    }
    
    func navigateToNextScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let authVC = mainStoryboard.instantiateViewController(withIdentifier: "SegmentViewController") as? SegmentViewController {
            setRootViewController(authVC)
        }
    }
    
    private func navigateToHomeDirectly() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let authVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController {
            setRootViewController(authVC)
        }
    }

    private func setRootViewController(_ controller: UIViewController) {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = view.window ?? windowScene.windows.first(where: { $0.isKeyWindow }) ?? windowScene.windows.first
        else {
            return
        }

        window.rootViewController = controller
        window.makeKeyAndVisible()
    }

}
