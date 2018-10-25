//
//  StoryboardInstantiable.swift
//  CoordinatorExample
//
//  Created by Kyle Kirkland on 10/25/18.
//  Copyright © 2018 Kyle Kirkland. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: class {
    
    static var storyboardName: String { get }
    
}

extension StoryboardInstantiable {
    
    static func instantiatingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    static func instantiateInitial() -> Self {
        return instantiatingStoryboard().instantiateInitialViewController() as! Self
    }
    
    static func instantiate(with identifier: String) -> Self {
        return instantiatingStoryboard().instantiateViewController(withIdentifier: identifier) as! Self
    }
    
}
