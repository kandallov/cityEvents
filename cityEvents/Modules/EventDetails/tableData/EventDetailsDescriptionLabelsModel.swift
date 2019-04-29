//
//  EventDetailsDescriptionLabelsModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 4/12/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

class EventDetailsDescriptionLabelsModel: BaseElementEquitableModel {
    override var cellClass: UITableViewCell.Type { return BaseContainerTableViewCell<TwoLabelView>.self }
    
    var event: Event
    
    override var identity: String {
        return event.id ?? ""
    }
    
    init(with event: Event) {
        self.event = event
    }
    
    override func genericConfigureCell<T: BaseContainerTableViewCell<TwoLabelView>>(_ cell: T) {
        cell.backgroundColor = .clear
        cell.mViewContent.firstLabel.text = " - DESCRIPTION - "
        cell.mViewContent.secondLabel.text = event.description
    }
    
    public override func equalTo(other: BaseElementEquitableModel) -> Bool {
        guard let rhs = other as? EventCellModel else { return false }
        let lhs = self
        
        if lhs.identity != rhs.identity { return false }
        return true
    }
    
}
