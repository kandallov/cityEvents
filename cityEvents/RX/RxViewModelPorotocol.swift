//
//  RxViewModelProtocols.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift

protocol RxViewModelType {
    associatedtype InputDependencies
    associatedtype Input
    associatedtype Output
    
    func configure(input: Input) -> Output
}

protocol RxViewModelModuleType {
    associatedtype ModuleInput
    associatedtype ModuleOutput
    
    func configureModule(input: ModuleInput) -> ModuleOutput
}
