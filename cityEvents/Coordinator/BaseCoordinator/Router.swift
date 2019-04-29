//
//  Router.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/20/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

public typealias PresentationHandler = () -> Void

protocol RouterProtocol {
    associatedtype RootViewController: UIViewController
}

class Router<RootViewController: UIViewController>: RouterProtocol {
    weak var rootController: RootViewController?
    
    func define(root: RootViewController) {
        self.rootController = root
    }
    
    func unwrapPresentables(_ modules: [Presentable]) -> [UIViewController] {
        let controllers = modules.map { module -> UIViewController in
            return unwrapPresentable(module)
        }
        return controllers
    }
    
    func unwrapPresentable(_ module: Presentable) -> UIViewController {
        let controller = module.presentable()
        if controller is UINavigationController {
            assertionFailure("Forbidden push UINavigationController.")
        }
        return controller
    }
    
    // MARK: - Presentable
    
    func presentable() -> UIViewController {
        return rootController!
    }
    
    func presentId() -> String {
        return rootController!.presentId()
    }
    
    static func presentId() -> String {
        return UINavigationController.presentId()
    }
    
    deinit {
        print("Dead Router")
    }
}
