//
//  EventsViewController.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class EventsViewController: UIViewController {
    
    typealias SectionType = AnimatableSectionModel<String, BaseElementEquitableModel>
    
    // MARK: - Properties
    
    // Dependencies
    var viewModel: EventsViewOutput?
    
    // Public
    var bag = DisposeBag()
    
    // Private
    private let viewAppearState = PublishSubject<ViewAppearState>()
    private let loadNextPage = PublishSubject<Void>()
    private var isLoading = false

    // IBOutlet & UI
    lazy var customView: EventsView = {
        let customView = EventsView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
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
            assertionFailure("Please, set ViewModel as dependency for Events")
            return
        }
        
        let input = EventsViewModel.Input(
            appearState: viewAppearState,
            loadNextPage: loadNextPage.asObservable(),
            select: customView.tableView.rx.modelSelected(BaseElementModel.self).asObservable())
        let output = model.configure(input: input)
        
        output.title.subscribe(onNext: { [weak self] str in
            self?.navigationItem.title = str
        }).disposed(by: bag)
        
        output.state.subscribe(onNext: { [weak self] state in
            self?.isLoading = state == .networkActivity ? true : false
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
        customView.tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Additional
    
    deinit {
        print("EventsViewController deinit")
    }
}

extension EventsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height, !isLoading {
            loadNextPage.onNext(())
        }
    }
}
