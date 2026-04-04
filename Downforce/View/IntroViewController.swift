//
//  IntroViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 01/04/25.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleNumberLabel: UILabel!
    @IBOutlet weak var capLabelOne: UILabel!
    @IBOutlet weak var capLabelTwo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNumberAndCaptionAnimations()
    }

    func animateLogo() {
        let fullTitle = "Strat"
        titleNameLabel.text = ""

        let titleCharacters = Array(fullTitle)
        let typingDuration: TimeInterval = 1.0
        let characterInterval = typingDuration / TimeInterval(max(titleCharacters.count, 1))

        for (index, character) in titleCharacters.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (characterInterval * TimeInterval(index))) { [weak self] in
                guard let self = self else { return }
                self.titleNameLabel.text?.append(character)
            }
        }

        capLabelOne.alpha = 0
        capLabelTwo.alpha = 0
        capLabelOne.transform = CGAffineTransform(translationX: 0, y: 14)
        capLabelTwo.transform = CGAffineTransform(translationX: 0, y: 14)

        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseInOut], animations: {
            self.capLabelOne.alpha = 1
            self.capLabelTwo.alpha = 1
            self.capLabelOne.transform = .identity
            self.capLabelTwo.transform = .identity
        }) { _ in
            if let _ = UserDefaults.standard.string(forKey: "loggedInEmail") {
                self.navigateToHomeDirectly()
                return
            } else {
                self.navigateToNextScreen()
            }
        }
    }

    private func startNumberAndCaptionAnimations() {
        let numberSequence = ["1", "2", "3", "4", "2"]
        let totalNumberAnimationDuration: TimeInterval = 1.5
        let numberInterval = totalNumberAnimationDuration / TimeInterval(max(numberSequence.count - 1, 1))

        titleNumberLabel.text = numberSequence.first

        for (index, value) in numberSequence.enumerated() where index > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (numberInterval * TimeInterval(index))) { [weak self] in
                self?.titleNumberLabel.text = value
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + totalNumberAnimationDuration) { [weak self] in
            self?.animateLogo()
        }
    }

    private func navigateToNextScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let authVC = mainStoryboard.instantiateViewController(withIdentifier: "SegmentViewController") as? SegmentViewController {
            setRootViewController(authVC)
        }
    }

    private func navigateToHomeDirectly() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeTabBarVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBarController") as? UITabBarController {
            setRootViewController(homeTabBarVC)
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
