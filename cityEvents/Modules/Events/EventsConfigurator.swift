//
//  EventsConfigurator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

class EventsConfigurator {
    class func configure(inputData:EventsViewModel.ModuleInputData,
                         moduleInput: EventsViewModel.ModuleInput)
        -> (viewController: UIViewController, moduleOutput:EventsViewModel.ModuleOutput) {
            // View controller
            let viewController = createViewController()
            
            // Dependencies
            let dependencies = createDependencies()
            
            // View model
            let viewModel = EventsViewModel(dependencies: dependencies, moduleInputData: inputData)
            let moduleOutput = viewModel.configureModule(input: moduleInput)
            
            viewController.viewModel = viewModel
            
            return (viewController, moduleOutput)
    }
    
    private class func createViewController() -> EventsViewController {
        return EventsViewController()
    }
    
    private class func createDependencies() -> EventsViewModel.InputDependencies {
        let dependencies = EventsViewModel.InputDependencies(
            service: EventService(dp: EventService.Dependency(api: APIProvider<EventRoute>()))
        )
        return dependencies
    }
    
}
