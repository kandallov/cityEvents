//
//  Coordinatorable.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/20/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift

protocol CoordinatorRoute {}

protocol Coordinatorable: Presentable {
    func start()
}

protocol CoordinatorInput {
    associatedtype InputData
    associatedtype Dependencies
    
    func define(data: InputData, dp: Dependencies)
}

protocol CoordinatorOutput {
    associatedtype Output
    func configure() -> Output
}
