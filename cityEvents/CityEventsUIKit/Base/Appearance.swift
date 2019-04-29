//
//  Appearance.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 2/17/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

public protocol Appearance {
    var accessebilityId: String { get set }
}

public protocol AppearanceView {
    associatedtype AppearanceType: Appearance
    var appearance: AppearanceType { get set }
}

