//
//  ModuleFactory+App.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/23/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation

protocol AppModuleFactory {
    func appController() -> AppControllerProtocol
}

extension ModuleFactory: AppModuleFactory {
    
    func appController() -> AppControllerProtocol {
        let dp = AppController.Dependency()
        return AppController(dp: dp)
    }
    
}
