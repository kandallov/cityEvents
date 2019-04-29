//
//  TwoLabelView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 4/12/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit

public class TwoLabelView: BaseKitView, AppearanceView {
    
    public struct TwoLabelViewAppearance: Appearance {
        public var accessebilityId = "twoLabelView"
        public var contentInset = Sizes.L.value
        public var contentSpace = Sizes.M.value
        public var firstLabelFont = UIFont(name: "Avenir-Light", size: 21.0)
        public var firstLabelColor = UIColor.white
        public var firstLabelNumberOfLines = 0
        public var firstLabelTextAlignment = NSTextAlignment.center
        public var secondLabelFont = UIFont(name: "Avenir-Light", size: 15.0)
        public var secondLabelColor = UIColor.white
        public var secondLabelNumberOfLines = 0
        public var secondLabelTextAlignment = NSTextAlignment.center
    }
    
    public var firstLabel = UILabel()
    public var secondLabel = UILabel()
    
    public var appearance = TwoLabelViewAppearance () {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(firstLabel)
        addSubview(secondLabel)
    }
    
    override func configureSubviews() {
        accessibilityIdentifier = appearance.accessebilityId
        firstLabel.font = appearance.firstLabelFont
        firstLabel.textColor = appearance.firstLabelColor
        firstLabel.numberOfLines = appearance.firstLabelNumberOfLines
        firstLabel.textAlignment = appearance.firstLabelTextAlignment
        secondLabel.font = appearance.secondLabelFont
        secondLabel.textColor = appearance.secondLabelColor
        secondLabel.numberOfLines = appearance.secondLabelNumberOfLines
        secondLabel.textAlignment = appearance.secondLabelTextAlignment
    }
    
    override func makeConstraints() {
        firstLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(appearance.contentInset)
            make.right.equalToSuperview().offset(-appearance.contentInset)
        }
        secondLabel.snp.remakeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(appearance.contentSpace)
            make.left.equalToSuperview().offset(appearance.contentInset)
            make.right.equalToSuperview().offset(-appearance.contentInset)
            make.bottom.equalToSuperview()
        }
    }
}
