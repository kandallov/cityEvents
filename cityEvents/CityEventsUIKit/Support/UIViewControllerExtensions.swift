//
//  UIViewControllerExtensions.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 11/30/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var statusbarHeight: CGFloat {
        return view.statusbarHeight
    }
    
    var bottomInsetHeight: CGFloat {
        return view.bottomInsetHeight
    }
    
    var navigationBarHeight: CGFloat {
        return view.navigationBarHeight
    }
    
    func addSubview(_ view: UIView) {
        self.view.addSubview(view)
    }
}
