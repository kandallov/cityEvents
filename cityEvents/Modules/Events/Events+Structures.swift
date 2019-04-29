//
//  Events+Structures.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.

import Foundation
import RxSwift

extension EventsViewModel {
    
    enum OutputModuleActionType {
        case selectEvent(event: Event)
    }
    
    // MARK: - initial module data
    struct ModuleInputData {
        
    }
    
    // MARK: - module input structure
    struct ModuleInput {
        
    }
    
    // MARK: - module output structure
    struct ModuleOutput {
        let moduleAction: Observable<OutputModuleActionType>
    }
    
}
