//
//  Coordinator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/20/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension Coordinator {
    public typealias RootControllerType = RouterType.RootViewController
}

class Coordinator<RouteType: CoordinatorRoute, RouterType: RouterProtocol, DependencyType>: Coordinatorable {
    
    private var childs: [Presentable] = []
    
    var rootViewControllerBox: RootControllerType?
    var window: UIWindow?
    var initialRoute: RouteType
    let dp: DependencyType
    
    var rootViewController: RootControllerType {
        return rootViewControllerBox!
    }
    
    let bag = DisposeBag()
    let router: Router<RootControllerType>
    
    init(controller: RootControllerType?, dp: DependencyType, initialRoute: RouteType) {
        self.initialRoute = initialRoute
        self.router = Router<RootControllerType>()
        self.dp = dp
        
        if let controller = controller {
            rootViewControllerBox = controller
        } else {
            rootViewControllerBox = self.generateRootViewController()
        }
        
        self.router.define(root: rootViewController)
        self.configureRootViewController()
    }
    
    func generateRootViewController() -> RootControllerType {
        return RootControllerType()
    }
    
    func start() {
        trigger(initialRoute)
    }
    
    func configureRootViewController() {}
    
    func startCoordinator(_ coordinator: Coordinatorable) {
        addChild(coordinator)
        coordinator.start()
    }
    
    func addChild(_ child: Presentable) {
        for element in childs where element.presentId() == child.presentId() {
            return
        }
        
        childs.append(child)
    }
    
    func removeChild(_ child: Presentable?) {
        guard childs.isEmpty == false,
            let child = child
            else {
                return
        }
        
        for (index, element) in childs.enumerated() where element.presentId() == child.presentId() {
            childs.remove(at: index)
            break
        }
    }
    
    private func lastChild() -> Coordinatorable? {
        if let coord = childs.last as? Coordinatorable {
            print("Coordinator next is: \(coord.presentId())")
            return coord
        }
        
        return nil
    }
    
    func child(presentId: PresentableID) -> Presentable? {
        let items = childs.filter { item -> Bool in
            return item.presentId() == presentId
        }
        return items.first
    }
    
    func coordinator<T: Coordinatorable>(by type: T.Type) -> Coordinatorable? {
        return child(presentId: type.presentId()) as? Coordinatorable
    }
    
    func prepare(route: RouteType, completion: PresentationHandler?) {
        fatalError("Please override the \(#function) method.")
    }
    
    func trigger(_ route: RouteType, comletion: PresentationHandler? = nil) {
        prepare(route: route, completion: comletion)
    }
}

extension Coordinator: Presentable {
    func presentable() -> UIViewController {
        return router.presentable()
    }
    
    func presentId() -> PresentableID {
        return String(describing: type(of: self))
    }
    
    static func presentId() -> PresentableID {
        return String(describing: self)
    }
}
