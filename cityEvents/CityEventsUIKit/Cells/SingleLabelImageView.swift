//
//  SingleLabelImageView.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 12/12/18.
//  Copyright © 2018 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

public class SingleLabelImageView: BaseKitView, AppearanceView {
    
    public struct SingleLabelImageViewAppearance: Appearance {
        public var accessebilityId = "singleLabelImageView"
        public var titleLabelFont = UIFont(name: "Avenir-Light", size: 32.0)
        public var titleLabelTextColor = UIColor.white
        public var titleLabelNumberOfLines = 0
        public var titleLabelTextAlignment = NSTextAlignment.center
        public var imageHight = 200
        public var imageContentMode: ContentMode = .center
        public var overlayColor = UIColor.black
        public var overlayAlpha: CGFloat = 0.6
        public var offset = Sizes.pixel.value
    }
    
    public var label = UILabel()
    public var imageView = UIImageView()
    public var overlay = UIView()
    
    public var appearance = SingleLabelImageViewAppearance() {
        didSet {
            configureSubviews()
            makeConstraints()
        }
    }
    
    override func addSubviews() {
        addSubview(imageView)
        addSubview(overlay)
        addSubview(label)
    }
    
    override func configureSubviews() {
        accessibilityIdentifier = appearance.accessebilityId
        label.font = appearance.titleLabelFont
        label.textColor = appearance.titleLabelTextColor
        label.numberOfLines = appearance.titleLabelNumberOfLines
        label.textAlignment = appearance.titleLabelTextAlignment
        imageView.contentMode = appearance.imageContentMode
        overlay.backgroundColor = appearance.overlayColor
        overlay.alpha = appearance.overlayAlpha
    }
    
    override func makeConstraints() {
        imageView.snp.remakeConstraints { make in
            make.height.equalTo(appearance.imageHight)
            make.bottom.equalToSuperview().offset(-appearance.offset)
            make.top.equalToSuperview().offset(appearance.offset)
            make.left.right.equalToSuperview()
        }
        
        overlay.snp.remakeConstraints { make in
            make.bottom.top.left.right.equalTo(imageView)
        }
        
        label.snp.remakeConstraints { make in
            make.top.left.equalToSuperview().offset(Sizes.M.value)
            make.bottom.right.equalToSuperview().offset(-Sizes.M.value)
        }
    }
}
