//
//  EventDetailsLabelImageModel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 4/12/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import AlamofireImage

class EventDetailsLabelImageModel: BaseElementEquitableModel {
    override var cellClass: UITableViewCell.Type { return BaseContainerTableViewCell<SingleLabelImageView>.self }
    
    var event: Event
    
    override var identity: String {
        return event.id ?? ""
    }
    
    init(with event: Event) {
        self.event = event
    }
    
    override func genericConfigureCell<T: BaseContainerTableViewCell<SingleLabelImageView>>(_ cell: T) {
        cell.backgroundColor = .white
        guard let url = URL(string: event.logoUrl ?? "") else { return }
        let placeHolder = UIImage(named: "placeHolder")
        let sizeFilter = AspectScaledToFillSizeFilter(size: CGSize(width: UIScreen.main.bounds.width, height: 200))
        cell.mViewContent.imageView.af_setImage(withURL: url, placeholderImage: placeHolder, filter: sizeFilter)
    }
    
    public override func equalTo(other: BaseElementEquitableModel) -> Bool {
        guard let rhs = other as? EventCellModel else { return false }
        let lhs = self
        
        if lhs.identity != rhs.identity { return false }
        return true
    }
    
}
