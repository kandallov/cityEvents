//
//  Sizes.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 2/17/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

public enum Sizes {
    case XS
    case S
    case M
    case L
    case XL
    case pixel
    
    public var value: CGFloat {
        switch self {
        case .XS:
            return 2
        case .S:
            return 5
        case .M:
            return 10
        case .L:
            return 15
        case .XL:
            return 20
        case .pixel:
            return 1 / UIScreen.main.scale
        }
    }
}
