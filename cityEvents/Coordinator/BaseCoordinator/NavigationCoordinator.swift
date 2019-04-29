//
//  NavigationCoordinator.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/21/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import UIKit

typealias NavigationRouter = Router<UINavigationController>

extension Router where RootViewController: UINavigationController {
    func push(_ viewController: Presentable,
              completion: PresentationHandler? = nil) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        self.rootController?.pushViewController(unwrapPresentable(viewController), animated: true)
        
        CATransaction.commit()
    }
    
    func pop(toRoot: Bool, completion: PresentationHandler? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        if toRoot {
            self.rootController?.popToRootViewController(animated: true)
        } else {
            self.rootController?.popViewController(animated: true)
        }
        
        CATransaction.commit()
    }
    
    func set(_ viewControllers: [Presentable],
             completion: PresentationHandler? = nil, barHidden: Bool = false) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        let controllers = unwrapPresentables(viewControllers)
        self.rootController?.setViewControllers(controllers, animated: false)
        self.rootController?.isNavigationBarHidden = barHidden
        
        CATransaction.commit()
    }
    
    func pop(to viewController: Presentable,
             completion: PresentationHandler? = nil) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        
        self.rootController?.popToViewController(unwrapPresentable(viewController), animated: true)
        
        CATransaction.commit()
    }
}

class NavigationCoordinator<RouteType: CoordinatorRoute, DependencyType>: Coordinator<RouteType, NavigationRouter, DependencyType> {
    init(window: UIWindow, dp: DependencyType, initialRoute: RouteType) {
        super.init(controller: nil, dp: dp, initialRoute: initialRoute)
        self.window = window
        setRoot(for: window)
    }
    
    init(rootViewController: UINavigationController? = nil, dp: DependencyType, initialRoute: RouteType) {
        super.init(controller: rootViewController, dp: dp, initialRoute: initialRoute)
    }
    
    override func generateRootViewController() -> UINavigationController {
        return super.generateRootViewController()
    }
    
    deinit {
        print("Dead NavigationCoordinator")
    }
}
