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
    
    }
}


// MARK: - StoryboardInstantiable

extension HomeViewController: StoryboardInstantiable {
    
    static var storyboardName: String {
        return "Home"
    }
    
    class func build() -> HomeViewController {
        let homeViewController = instantiateInitial()
        return homeViewController
    }
    
}

