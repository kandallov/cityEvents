//
//  EventDetails+Structures.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/26/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.

import Foundation
import RxSwift

extension EventDetailsViewModel {
    
    enum OutputModuleActionType {
        
    }
    
    // MARK: - initial module data
    struct ModuleInputData {
        let event: Event
    }
    
    // MARK: - module input structure
    struct ModuleInput {
        
    }
    
    // MARK: - module output structure
    struct ModuleOutput {
        let moduleAction: Observable<OutputModuleActionType>
    }
    
}
