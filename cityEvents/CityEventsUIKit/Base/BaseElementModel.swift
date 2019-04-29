//
//  BaseElementModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 2/17/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

protocol BaseElementModelProtocol {
    var cellClass: UITableViewCell.Type { get }
    func configureCell(_ cell: UITableViewCell)
}

class BaseElementModel: NSObject, BaseElementModelProtocol {
    var cellClass:UITableViewCell.Type { return UITableViewCell.self }
    func configureCell(_ cell: UITableViewCell) {
        self.genericConfigureCell(cell)
    }
    
    func genericConfigureCell<T: UITableViewCell>(_ cell: T) {
        
    }
}
