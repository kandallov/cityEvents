//
//  ModuleFactory+Login.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/23/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import UIKit

protocol EventModuleFactory {
    func eventModule() -> (viewController: UIViewController, moduleOutput:EventsViewModel.ModuleOutput)
}

extension ModuleFactory: EventModuleFactory {
    
    func eventModule() -> (viewController: UIViewController, moduleOutput:EventsViewModel.ModuleOutput) {
        let inputData = EventsViewModel.ModuleInputData()
        let input = EventsViewModel.ModuleInput()
        return EventsConfigurator.configure(inputData: inputData, moduleInput: input)
    }
    
}
