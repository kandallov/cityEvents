//
//  EmptyTableViewCell.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/12/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit

public class EmptyTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        makeConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(Sizes.M.value)
        }
    }
    
}
