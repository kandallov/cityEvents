//
//  SingleLabel.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 4/12/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

public class SingleLabelView: BaseKitView, AppearanceView {
    
    public struct SingleLabelViewAppearance: Appearance {
        public var accessebilityId = "singleLabelView"
        public var titleLabelFont = UIFont(name: "Avenir-Light", size: 17.0)
        public var titleLabelTextColor = UIColor.white
        public var titleLabelNumberOfLines = 0
        public var titleLabelTextAlignment = NSTextAlignment.center
        public var offset = Sizes.M.value
    }
    
    public var label = UILabel()
    
    public var appearance = SingleLabelViewAppearance() {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(label)
    }
    
    override func configureSubviews() {
        accessibilityIdentifier = appearance.accessebilityId
        label.font = appearance.titleLabelFont
        label.textColor = appearance.titleLabelTextColor
        label.numberOfLines = appearance.titleLabelNumberOfLines
        label.textAlignment = appearance.titleLabelTextAlignment
    }
    
    override func makeConstraints() {
        label.snp.remakeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(appearance.offset)
        }
    }
}

