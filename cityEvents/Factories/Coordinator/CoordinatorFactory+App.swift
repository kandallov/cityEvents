//
//  CoordinatorFactory+App.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/23/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorFactory {
    func appCoordinator(window: UIWindow) -> Coordinatorable
}

extension CoordinatorFactory: AppCoordinatorFactory {
    
    func appCoordinator(window: UIWindow) -> Coordinatorable {
        let dp = AppCoordinator.Dependencies(
            coordinatorFactory: CoordinatorFactory(),
            moduleFactory: ModuleFactory())
        return AppCoordinator(window: window, dp: dp, initialRoute: .event)
    }
    
}
