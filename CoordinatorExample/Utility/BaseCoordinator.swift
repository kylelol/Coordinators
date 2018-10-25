//
//  BaseCoordinator.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation

class BaseCoordinator: CoordinatorType {
    
    let uuid: UUID = UUID()
    var childCoordinators: [CoordinatorType] = []
    
    func start() {
        preconditionFailure("A subclass must override start()")
    }
    
}
