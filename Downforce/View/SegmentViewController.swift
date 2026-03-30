//
//  SegmentViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 23/03/26.
//

import UIKit

class SegmentViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["Sign in", "Register"])
    private lazy var loginVC: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    }()
    private lazy var registerVC: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SignupViewController")
    }()
    
    var currentVC: UIViewController?
    
    let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl
            .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl
            .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        showInitial()
    }

    private func setupLayout() {
        view.addSubview(containerView)
        view.addSubview(segmentedControl)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showInitial() {
        addChild(loginVC)
        addFullScreen(childView: loginVC.view, to: containerView)
        loginVC.didMove(toParent: self)
        currentVC = loginVC
    }
    
    @objc func segmentChanged() {
        let selectedVC = segmentedControl.selectedSegmentIndex == 0 ? loginVC: registerVC
        switchTo(selectedVC)
    }
    
    func switchTo(_ newVC: UIViewController) {
        guard let currentVC = currentVC else { return }
        guard currentVC !== newVC else { return }
        
        addChild(newVC)
        addFullScreen(childView: newVC.view, to: containerView)
        newVC.view.alpha = 0
        currentVC.willMove(toParent: nil)

        UIView.animate(withDuration: 0.25, animations: {
            newVC.view.alpha = 1
            currentVC.view.alpha = 0
        }, completion: { _ in
            currentVC.view.alpha = 1
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
            newVC.didMove(toParent: self)
            self.currentVC = newVC
        })
    }

    private func addFullScreen(childView: UIView, to container: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: container.topAnchor),
            childView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            childView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
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
