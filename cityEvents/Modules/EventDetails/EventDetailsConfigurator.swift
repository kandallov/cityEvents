//
//  EventDetailsConfigurator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/26/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

class EventDetailsConfigurator {
    class func configure(inputData:EventDetailsViewModel.ModuleInputData,
                         moduleInput: EventDetailsViewModel.ModuleInput)
        -> (viewController: UIViewController, moduleOutput:EventDetailsViewModel.ModuleOutput) {
            // View controller
            let viewController = createViewController()
            
            // Dependencies
            let dependencies = createDependencies()
            
            // View model
            let viewModel = EventDetailsViewModel(dependencies: dependencies, moduleInputData: inputData)
            let moduleOutput = viewModel.configureModule(input: moduleInput)
            
            viewController.viewModel = viewModel
            
            return (viewController, moduleOutput)
    }
    
    private class func createViewController() -> EventDetailsViewController {
        return EventDetailsViewController()
    }
    
    private class func createDependencies() -> EventDetailsViewModel.InputDependencies {
        let dependencies = EventDetailsViewModel.InputDependencies()
        return dependencies
    }
    
}
