//
//  EventDetailsView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/26/19.
//  Copyright (c) 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

class EventDetailsView: UIView {
    
    public var tableView = UITableView()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configureView()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureView() {
        backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 77
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    public func makeConstraints(vc: UIViewController) {
        tableView.snp.remakeConstraints { maker in
            maker.left.top.right.bottom.equalToSuperview()
        }
    }
}
