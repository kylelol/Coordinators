//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    let presenter: UIWindow
    
    init(window: UIWindow) {
        self.presenter = window
    }
    
    override func start() {
        if UserDefaults.standard.bool(forKey: "isSignedIn") {
            let homeCoordinator = HomeCoordinator(presenter: presenter)
            coordinate(to: homeCoordinator)
        } else {
            let signUpCoordinator = SignUpCoordinator(presenter: presenter)
            signUpCoordinator.delegate = self
            coordinate(to: signUpCoordinator)
        }
    }
    
}

extension AppCoordinator: SignUpCoordinatorDelegate {
    
    func didSignUp(with newUser: NewUser) {
        UserDefaults.standard.set(true, forKey: "isSignedIn")
        let homeCoordinator = HomeCoordinator(presenter: presenter)
        coordinate(to: homeCoordinator)
    }
    
}
