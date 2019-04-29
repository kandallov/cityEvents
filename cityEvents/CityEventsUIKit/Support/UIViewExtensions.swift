//
//  UIViewExtensions.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 11/30/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit

extension UIView {
    var statusbarHeight: CGFloat {
        guard #available(iOS 11.0, *) else { return 20 }
        guard let insets = UIApplication.shared.delegate?.window??.safeAreaInsets else { return 20 }
        return max(insets.top, 20)
    }
    
    var bottomInsetHeight: CGFloat {
        guard #available(iOS 11.0, *) else { return 0 }
        guard let insets = UIApplication.shared.delegate?.window??.safeAreaInsets else { return 0 }
        return max(insets.bottom, 0)
    }
    
    var navigationBarHeight: CGFloat {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return 32
        } else {
            return 44
        }
    }
}
