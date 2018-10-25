//
//  HomeCoordinator.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation
import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    let presenter: UIWindow
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    override func start() {
        let homeViewController = HomeViewController.build()
        presenter.rootViewController = homeViewController
        presenter.makeKeyAndVisible()
    }
    
}
