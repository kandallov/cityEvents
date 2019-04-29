//
//  EventCoordinator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/27/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum EventCoordinatorRoute: CoordinatorRoute {
    case events
    case selectEvent(event: Event)
    case pop
}

class EventCoordinator: NavigationCoordinator<EventCoordinatorRoute, EventCoordinator.Dependencies> {
    
    // Coordinator structures
    struct Dependencies {
        let moduleFactory: ModuleFactory
    }
    struct Output {

    }
    
    // Public functions
    
    func configure() -> EventCoordinator.Output {
        return Output()
    }
    
    override func prepare(route: EventCoordinatorRoute, completion: PresentationHandler?) {
        switch route {
        case .events:
            router.set([events()])
        case let .selectEvent(event):
            router.push(selectEvent(for: event))
        case .pop:
            router.pop(toRoot: false)
        }
    }
    
    deinit {
        print("Dead AuthCoordinator")
    }
}

extension EventCoordinator {
    
    func events() -> Presentable {
        let inputData = EventsViewModel.ModuleInputData()
        let input = EventsViewModel.ModuleInput()
        let (controller, output) = EventsConfigurator.configure(inputData: inputData, moduleInput: input)
        output.moduleAction.subscribe(onNext: { action in
            switch action {
            case let .selectEvent(event):
                self.trigger(.selectEvent(event: event))
            }
        }).disposed(by: bag)
        return controller
    }
    
    func selectEvent(for event: Event) -> Presentable {
        let inputData = EventDetailsViewModel.ModuleInputData(event: event)
        let input = EventDetailsViewModel.ModuleInput()
        let (controller, output) = EventDetailsConfigurator.configure(inputData: inputData, moduleInput: input)
        output.moduleAction.subscribe(onNext: { (action) in
        }).disposed(by: bag)
        return controller
    }
}
