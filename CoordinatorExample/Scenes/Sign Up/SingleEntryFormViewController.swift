//
//  SingleEntryFormViewController.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import UIKit

protocol SingleEntryFormViewControllerDelegate: class {
    
    func didTapCancel(in viewController: SingleEntryFormViewController)
    func didSignUp(in viewController: SingleEntryFormViewController)
    
}

final class SingleEntryFormViewController: UIViewController {

    enum Intent {
        
        case email
        case username
        case password
        
    }
    
    @IBOutlet private var intentDescriptionLabel: UILabel!
    @IBOutlet private var inputTextField: UITextField!
    
    weak var delegate: SingleEntryFormViewControllerDelegate?
    
    var newUser: NewUser?
    
    var intent: Intent = .email {
        didSet {
            displayIntent()
        }
    }

}

// MARK: - UIViewController

extension SingleEntryFormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayIntent()
        
        if navigationController?.viewControllers.count == 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton(_:)))
        }
        
        switch intent {
        case .email, .username:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
        case .password:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapRightBarButtonItem(_:)))
        }
    }
    
}

// MARK: - Helpers

private extension SingleEntryFormViewController {
    
    func displayIntent() {
        guard isViewLoaded else { return }
        
        switch intent {
        case .email:
            intentDescriptionLabel.text = "Enter in your email."
            inputTextField.placeholder = "johndoe@test.com"
        case .username:
            intentDescriptionLabel.text = "Enter in a unique username."
            inputTextField.placeholder = "honeybadger1992"
        case .password:
            intentDescriptionLabel.text = "Enter in your secret password."
            inputTextField.placeholder = "********"
        }
    }
    
    @objc dynamic func didTapCancelButton(_ sender: Any) {
        delegate?.didTapCancel(in: self)
    }
    
    @objc dynamic func didTapRightBarButtonItem(_ sender: Any) {
        switch intent {
        case .username:
            newUser?.username = inputTextField.text
            presentNextForm(with: .email)
        case .email:
            newUser?.email = inputTextField.text
            presentNextForm(with: .password)
        case .password:
            newUser?.password = inputTextField.text
            delegate?.didSignUp(in: self)
        }
    }
    
    func presentNextForm(with intent: Intent) {
        let nextFormViewController = storyboard?.instantiateInitialViewController() as! SingleEntryFormViewController
        nextFormViewController.intent = intent
        nextFormViewController.newUser = newUser
        nextFormViewController.delegate = delegate
        navigationController?.pushViewController(nextFormViewController, animated: true)
    }
    
}

// MARK: - StoryboardInstantiable

extension SingleEntryFormViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return "SignUp"
    }
    
    class func build(intent: Intent, newUser: NewUser?, delegate: SingleEntryFormViewControllerDelegate) -> SingleEntryFormViewController {
        let singleEntryFormViewController = instantiateInitial()
        singleEntryFormViewController.intent = intent
        singleEntryFormViewController.newUser = newUser
        singleEntryFormViewController.delegate = delegate
        return singleEntryFormViewController
    }
    
}
