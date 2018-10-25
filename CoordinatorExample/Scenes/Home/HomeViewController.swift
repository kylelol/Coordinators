//
//  ViewController.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!

}

// MARK: - UIViewController

extension HomeViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: "isSignedIn") {
            presentSignUpFlow()
        }
    }
}

// MARK: - Helpers

extension HomeViewController {
    
    private func presentSignUpFlow() {
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let singleEntryFormViewController = signUpStoryboard.instantiateInitialViewController() as! SingleEntryFormViewController
        singleEntryFormViewController.intent = .username
        singleEntryFormViewController.delegate = self
        singleEntryFormViewController.newUser = NewUser()
        let navigationController = UINavigationController(rootViewController: singleEntryFormViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
}

// MARK: - SingleEntryFormViewControllerDelegate

extension HomeViewController: SingleEntryFormViewControllerDelegate {
    
    func didTapCancel(in viewController: SingleEntryFormViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didSignUp(in viewController: SingleEntryFormViewController) {
        UserDefaults.standard.set(true, forKey: "isSignedIn")
        usernameLabel.text = viewController.newUser?.username
        emailLabel.text = viewController.newUser?.email
        dismiss(animated: true, completion: nil)
    }
}

