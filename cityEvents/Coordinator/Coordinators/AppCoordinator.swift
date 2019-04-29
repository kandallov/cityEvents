//
//  AppCoordinator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/27/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum AppCoordinatorRoute: CoordinatorRoute {
    case event, pop
}

class AppCoordinator: NavigationCoordinator<AppCoordinatorRoute, AppCoordinator.Dependencies> {
    
    struct Dependencies {
        let coordinatorFactory: EventCoordinatorFactory
        let moduleFactory: AppModuleFactory
    }
    
    var appController: AppControllerProtocol?
    let triggerFlow = PublishSubject<Void>()
    
    override func prepare(route: AppCoordinatorRoute, completion: PresentationHandler?) {
        switch route {
        case .event:
            let coord = event()
            startCoordinator(coord)
        case .pop:
            router.pop(toRoot: false)
        }
    }
    
    override func configureRootViewController() {
        rootViewController.navigationBar.isTranslucent = false
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    override func start() {
        let controller = dp.moduleFactory.appController()
        self.appController = controller
        
        let startSignal = PublishSubject<Void>()
        let input = AppController.Input(
            start: startSignal.asObservable(),
            trigger: triggerFlow.asObservable())
        let output = controller.configure(input: input)
        output.flow.subscribe(onNext: { [weak self] (flow) in
            switch flow {
            case .event:
                self?.trigger(.event)
            }
        }).disposed(by: bag)
        
        startSignal.onNext( () )
    }
    
    deinit {
        print("Dead AppCoordinator")
    }
}

extension AppCoordinator {
    func event() -> Coordinatorable {
        let (coord, _) = self.dp.coordinatorFactory
            .eventCoordinator(rootViewController: rootViewController)
        return coord
    }
}
