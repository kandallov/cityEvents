//
//  BaseElementEquitableModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 2/17/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import Differentiator

class BaseElementEquitableModel: BaseElementModel, IdentifiableType {
    
    typealias Identity = String
    
    var identity: String {
        return ""
    }
    
    public func equalTo(other: BaseElementEquitableModel) -> Bool {
        return true
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? BaseElementEquitableModel {
            return self.equalTo(other: rhs)
        }
        return false
    }
    
}
