//
//  EventsViewModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventsViewOutput {
    func configure(input: EventsViewModel.Input) -> EventsViewModel.Output
}

class EventsViewModel: RxViewModelType, RxViewModelModuleType, EventsViewOutput {
    
    // MARK: In/Out struct
    struct InputDependencies {
        let service: EventServiceProtocol
    }
    
    struct Input {
        let appearState: Observable<ViewAppearState>
        let loadNextPage: Observable<Void>
        let select: Observable<BaseElementModel>
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
    private var isHasNext = false
    private var pageNumber = 1
    
    // MARK: Observables
    private let title = Observable.just("Events")
    private let outputModuleAction = PublishSubject<OutputModuleActionType>()
    private let tableData = PublishSubject<[BaseElementEquitableModel]>()
    
    // MARK: Data
    private var events: [Event] = []
    
    // MARK: - initializer
    init(dependencies: InputDependencies, moduleInputData: ModuleInputData) {
        self.dp = dependencies
        self.moduleInputData = moduleInputData
    }
    
    // MARK: - EventsViewOutput
    func configure(input: Input) -> Output {
        // Configure input
        input.appearState.subscribe(onNext: { [weak self] (state) in
            if state == .didLoad {
                self?.start()
            }
        }).disposed(by: bag)
        
        input.loadNextPage.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.downloadNext()
        }).disposed(by: bag)
        
        input.select.subscribe(onNext: { [weak self] model in
            if let model = model as? EventCellModel {
                self?.outputModuleAction.onNext(.selectEvent(event: model.event))
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
        downloadData()
    }
    
    private func downloadData() {
        modelState.change(state:.networkActivity)
        dp.service.getEvents(with: "San-Francisco", page: "1").subscribe(
            onNext: { [weak self] (eventsBrite) in
                self?.modelState.change(state:.normal)
                self?.isHasNext = eventsBrite.pagination?.hasMoreItems ?? false
                self?.pageNumber = eventsBrite.pagination?.pageNumber ?? 1
                guard let events = eventsBrite.events else { return }
                self?.events = events
                self?.buildTableData()
            }, onError: { [weak self] error in
                self?.modelState.change(state: .error(error as NSError))
                print(error.localizedDescription)
        }).disposed(by: bag)
    }
    
    private func downloadNext() {
        modelState.change(state:.networkActivity)
        dp.service.getEvents(with: "San-Francisco", page: (pageNumber + 1).description).subscribe(
            onNext: { [weak self] (eventsBrite) in
                self?.modelState.change(state:.normal)
                self?.isHasNext = eventsBrite.pagination?.hasMoreItems ?? false
                self?.pageNumber = eventsBrite.pagination?.pageNumber ?? 1
                guard let events = eventsBrite.events else { return }
                self?.events.append(contentsOf: events)
                self?.buildTableData()
            }, onError: { [weak self] error in
                self?.modelState.change(state: .error(error as NSError))
                print(error.localizedDescription)
        }).disposed(by: bag)
        
    }
    
    private func buildTableData() {
        var data: [BaseElementEquitableModel] = []
        for event in events {
            data.append(EventCellModel(with: event))
        }
        tableData.onNext(data)
    }
    
    deinit {
        print("-- EventsViewModel dead")
    }
}
