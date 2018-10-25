//
//  CoordinatorType.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation

protocol CoordinatorType: class {
    
    var childCoordinators: [CoordinatorType] { get set }
    var uuid: UUID { get }
    func start()
    
}

extension CoordinatorType {
    
    func add(childCoordinator: CoordinatorType) {
        childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: CoordinatorType) {
        guard let index = childCoordinators.index(where: { otherCoordinator in
            return otherCoordinator.uuid == childCoordinator.uuid
        }) else
        {
            return
        }
        
        childCoordinators.remove(at: index)
    }
    
    func removeAllChildren() {
        childCoordinators.removeAll()
    }
    
}
