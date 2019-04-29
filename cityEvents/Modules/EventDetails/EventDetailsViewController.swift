//
//  EventDetailsViewController.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/26/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class EventDetailsViewController: UIViewController {
    
    typealias SectionType = AnimatableSectionModel<String, BaseElementEquitableModel>
    
    // MARK: - Properties
    
    // Dependencies
    var viewModel: EventDetailsViewOutput?
    
    // Public
    var bag = DisposeBag()
    
    // Private
    private let viewAppearState = PublishSubject<ViewAppearState>()
    
    // IBOutlet & UI
    lazy var customView: EventDetailsView = {
        let customView = EventDetailsView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        return customView
    }()
    
    // MARK: - View lifecycle
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureRx()
        viewAppearState.onNext(.didLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewAppearState.onNext(.willAppear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewAppearState.onNext(.didAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewAppearState.onNext(.willDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewAppearState.onNext(.didDisappear)
    }
    
    // MARK: - Configuration
    private func configureRx() {
        guard let model = viewModel else {
            assertionFailure("Please, set ViewModel as dependency for EventDetails")
            return
        }
        
        let input = EventDetailsViewModel.Input(appearState: viewAppearState)
        let output = model.configure(input: input)
        
        output.title.subscribe(onNext: { [weak self] str in
            self?.navigationItem.title = str
        }).disposed(by: bag)
        
        output.state.subscribe(onNext: { state in
            // state handler
        }).disposed(by: bag)
        
        // table data
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionType>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .none, deleteAnimation: .automatic),
            configureCell: { (_, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withClass: element.cellClass, for: indexPath)
                element.configureCell(cell)
                return cell
        })
        
        output.tableData
            .map({ [SectionType(model: "Default", items: $0)] })
            .bind(to: customView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func configureUI() {
        customView.makeConstraints(vc: self)
    }
    
    // MARK: - Additional
    
    deinit {
        print("EventDetailsViewController deinit")
    }
}
