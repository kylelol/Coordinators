//
//  SignUpCoordinator.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpCoordinatorDelegate: class {
    
    func didSignUp(with newUser: NewUser)
    
}

final class SignUpCoordinator: BaseCoordinator {
    
    
    let presenter: UIWindow
    var navigationController: UINavigationController?
    let newUser: NewUser = NewUser()
    
    weak var delegate: SignUpCoordinatorDelegate?
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    override func start() {
        presentSingleEntryFormViewController(for: .username)
    }
    
    func presentSingleEntryFormViewController(for intent: SingleEntryFormViewController.Intent) {
        let singleEntryFormViewController = SingleEntryFormViewController.build(intent: intent)
        
        switch intent {
        case .email:
            singleEntryFormViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
            navigationController?.pushViewController(singleEntryFormViewController, animated: true)
        case .username:
            singleEntryFormViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
            navigationController = UINavigationController(rootViewController: singleEntryFormViewController)
            presenter.rootViewController = navigationController!
            presenter.makeKeyAndVisible()
        case .password:
            singleEntryFormViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
            navigationController?.pushViewController(singleEntryFormViewController, animated: true)
        }
    }
    
    @objc dynamic func didTapRightBarButtonItem(_ sender: Any) {
        guard let singleEntryFormViewController = navigationController?.viewControllers.last as? SingleEntryFormViewController else {
            return
        }
        
        switch singleEntryFormViewController.intent {
        case .username:
            newUser.username = singleEntryFormViewController.inputTextField.text
            presentSingleEntryFormViewController(for: .email)
        case .email:
            newUser.email = singleEntryFormViewController.inputTextField.text
            presentSingleEntryFormViewController(for: .password)
        case .password:
            newUser.password = singleEntryFormViewController.inputTextField.text
            delegate?.didSignUp(with: newUser)
        }
    }
    
}
