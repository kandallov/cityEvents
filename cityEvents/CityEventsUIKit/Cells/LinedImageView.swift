//
//  LinedImageView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/13/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit

public class LinedImageView: BaseKitView, AppearanceView {
    
    public struct LinedImageViewAppearance: Appearance {
        public var accessebilityId = "linedImageView"
        public var contentInset = Sizes.M.value
        public var lineImageViewBackgroundColor = UIColor.clear
        public var lineImageViewWight = 100
        public var lineImageViewHight = 20
    }
    
    public var lineImageView = UIImageView()
    
    public var appearance = LinedImageViewAppearance () {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(lineImageView)
    }
    
    override func configureSubviews() {
        accessibilityIdentifier = appearance.accessebilityId
        lineImageView.backgroundColor = appearance.lineImageViewBackgroundColor
    }
    
    override func makeConstraints() {
        lineImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(appearance.lineImageViewWight)
            make.height.equalTo(appearance.lineImageViewHight)
        }
    }
}
