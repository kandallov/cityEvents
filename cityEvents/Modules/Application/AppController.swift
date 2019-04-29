//
//  AppController.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/18/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppControllerProtocol {
    func configure(input: AppController.Input) -> AppController.Output
}

class AppController: AppControllerProtocol {
    
    // Internal
    private let dp: Dependency
    private let bag = DisposeBag()
    private let flow = PublishSubject<Flow>()
    
    init(dp: Dependency) {
        self.dp = dp
    }
    
    func configure(input: AppController.Input) -> AppController.Output {
        input.start.subscribe(onNext: { [weak self] in
            self?.start()
        }).disposed(by: bag)
        input.trigger.subscribe(onNext: { [weak self] in
            self?.triggerFlow()
        }).disposed(by: bag)
        
        return Output(flow: flow.asObservable())
    }
    
    func start() {
        triggerFlow()
    }
    
    func triggerFlow() {
        flow.onNext(.event)
    }
    
}

// Structures
extension AppController {
    
    enum Flow {
        case event
    }
    
    struct Input {
        let start: Observable<Void>
        let trigger: Observable<Void>
    }
    
    struct Output {
        let flow: Observable<Flow>
    }
    
    struct Dependency {
        
    }
}
