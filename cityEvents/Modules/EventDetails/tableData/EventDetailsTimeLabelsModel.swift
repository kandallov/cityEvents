//
//  EventDetailsTimeLabelsModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 4/12/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

class EventDetailsTimeLabelsModel: BaseElementEquitableModel {
    override var cellClass: UITableViewCell.Type { return BaseContainerTableViewCell<ThreeLabelView>.self }
    
    var event: Event
    
    override var identity: String {
        return event.id ?? ""
    }
    
    init(with event: Event) {
        self.event = event
    }
    
    override func genericConfigureCell<T: BaseContainerTableViewCell<ThreeLabelView>>(_ cell: T) {
        cell.backgroundColor = .clear
        cell.mViewContent.firstLabel.text = " - TIME - "
        cell.mViewContent.secondLabel.text = "start: \(String.fromDate(event.start ?? Date(), .EEEEMMMMddHHmm))"
        cell.mViewContent.thirdLabel.text = "end: \(String.fromDate(event.end ?? Date(), .EEEEMMMMddHHmm))"
    }
    
    public override func equalTo(other: BaseElementEquitableModel) -> Bool {
        guard let rhs = other as? EventCellModel else { return false }
        let lhs = self
        
        if lhs.identity != rhs.identity { return false }
        return true
    }
    
}
