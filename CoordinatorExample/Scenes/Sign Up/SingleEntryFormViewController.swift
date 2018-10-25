//
//  SingleEntryFormViewController.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import UIKit

final class SingleEntryFormViewController: UIViewController {

    enum Intent {
        
        case email
        case username
        case password
        
    }
    
    @IBOutlet private var intentDescriptionLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
        
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
    
}

// MARK: - StoryboardInstantiable

extension SingleEntryFormViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return "SignUp"
    }
    
    class func build(intent: Intent) -> SingleEntryFormViewController {
        let singleEntryFormViewController = instantiateInitial()
        singleEntryFormViewController.intent = intent
        return singleEntryFormViewController
    }
    
}
