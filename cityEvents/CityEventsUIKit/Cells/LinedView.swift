//
//  LinedView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/3/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit

public class LinedView: BaseKitView, AppearanceView {
    
    public struct LinedViewAppearance: Appearance {
        public var accessebilityId = "linedView"
        public var lineViewHeight = Sizes.pixel.value
        public var lineViewWidth = Sizes.L.value
        public var lineViewBackgroundColor = UIColor.white
    }
    
    public var lineView = UIView()
    
    public var appearance = LinedViewAppearance() {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(lineView)
    }
    
    override func configureSubviews() {
        accessibilityIdentifier = appearance.accessebilityId
        lineView.backgroundColor = appearance.lineViewBackgroundColor
    }
    
    override func makeConstraints() {
        lineView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.center.equalToSuperview()
            make.width.equalTo(appearance.lineViewWidth)
            make.height.equalTo(appearance.lineViewHeight)
        }
    }
}
