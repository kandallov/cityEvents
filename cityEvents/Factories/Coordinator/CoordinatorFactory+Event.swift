//
//  CoordinatorFactory+Event.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/23/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import UIKit

protocol EventCoordinatorFactory {
    func eventCoordinator(rootViewController: UINavigationController) -> (Coordinatorable, EventCoordinator.Output)
}

extension CoordinatorFactory: EventCoordinatorFactory {
    
    func eventCoordinator(rootViewController: UINavigationController) -> (Coordinatorable, EventCoordinator.Output) {
        let dp = EventCoordinator.Dependencies(moduleFactory: ModuleFactory())
        let coord = EventCoordinator(rootViewController: rootViewController, dp: dp, initialRoute: .events)
        
        return (coord, coord.configure())
    }
    
}
