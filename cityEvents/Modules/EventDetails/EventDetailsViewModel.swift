//
//  EventDetailsViewModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/26/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventDetailsViewOutput {
    func configure(input: EventDetailsViewModel.Input) -> EventDetailsViewModel.Output
}

class EventDetailsViewModel: RxViewModelType, RxViewModelModuleType, EventDetailsViewOutput {
    
    // MARK: In/Out struct
    struct InputDependencies {
        
    }
    
    struct Input {
        let appearState: Observable<ViewAppearState>
    }
    
    struct Output {
        let title: Observable<String>
        let state: Observable<ModelState>
        let tableData: Observable<[BaseElementEquitableModel]>
    }
    
    // MARK: Dependencies
    private let dp: InputDependencies
    private let moduleInputData: ModuleInputData
    
    // MARK: Properties
    private let bag = DisposeBag()
    private let modelState: RxViewModelStateProtocol = RxViewModelState()
    private var event: Event
    
    // MARK: Observables
    private let title = Observable.just("EventDetails")
    private let outputModuleAction = PublishSubject<OutputModuleActionType>()
    private let tableData = PublishSubject<[BaseElementEquitableModel]>()
    
    // MARK: - initializer
    
    init(dependencies: InputDependencies, moduleInputData: ModuleInputData) {
        self.dp = dependencies
        self.moduleInputData = moduleInputData
        
        self.event = moduleInputData.event
    }
    
    // MARK: - EventDetailsViewOutput
    
    func configure(input: Input) -> Output {
        // Configure input
        input.appearState.subscribe(onNext: { [weak self] state in
            // .didLoad and etc
            if state == .didLoad {
                self?.start()
            }
        }).disposed(by: bag)
        
        // Configure output
        return Output(
            title: title.asObservable(),
            state: modelState.state.asObservable(),
            tableData: tableData.asObservable())
    }
    
    // MARK: - Module configuration
    
    func configureModule(input: ModuleInput) -> ModuleOutput {
        // Configure input signals
        
        // Configure module output
        return ModuleOutput(
            moduleAction: outputModuleAction.asObservable()
        )
    }
    
    // MARK: - Additional
    
    private func start() {
        buildTableData()
    }
    
    private func buildTableData() {
        var data: [BaseElementEquitableModel] = []
        data.append(EventDetailsLabelImageModel(with: event))
        data.append(EventDetailsLabelModel(with: event))
        data.append(EventDetailsTimeLabelsModel(with: event))
        data.append(EventDetailsDescriptionLabelsModel(with: event))
        tableData.onNext(data)
    }
    
    deinit {
        print("-- EventDetailsViewModel dead")
    }
}
