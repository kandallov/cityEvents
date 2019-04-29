//
//  ThreeLabelView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/3/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit

public class ThreeLabelView: BaseKitView, AppearanceView {
    
    public struct ThreeLabelViewAppearance: Appearance {
        public var accessebilityId = "threeLabelView"
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
        public var thirdLabelFont = UIFont(name: "Avenir-Light", size: 15.0)
        public var thirdLabelColor = UIColor.white
        public var thirdLabelNumberOfLines = 0
        public var thirdLabelTextAlignment = NSTextAlignment.center
    }
    
    public var firstLabel = UILabel()
    public var secondLabel = UILabel()
    public var thirdLabel = UILabel()
    
    public var appearance = ThreeLabelViewAppearance () {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
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
        thirdLabel.font = appearance.thirdLabelFont
        thirdLabel.textColor = appearance.thirdLabelColor
        thirdLabel.numberOfLines = appearance.thirdLabelNumberOfLines
        thirdLabel.textAlignment = appearance.thirdLabelTextAlignment
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
        }
        thirdLabel.snp.remakeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).offset(appearance.contentSpace)
            make.left.equalToSuperview().offset(appearance.contentInset)
            make.right.equalToSuperview().offset(-appearance.contentInset)
            make.bottom.equalToSuperview().offset(-appearance.contentInset)
        }
    }
}

