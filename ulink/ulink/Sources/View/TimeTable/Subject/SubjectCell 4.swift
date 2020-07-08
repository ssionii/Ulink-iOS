//
//  SubjectCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SubjectCell: UICollectionViewCell {
    let textLabel = PaddingLabel()
    var borderLayer = CALayer()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        borderLayer.frame = self.bounds
        layer.addSublayer(borderLayer)
        
        textLabel.textAlignment = .left
        addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews(){
        super.layoutSubviews()
        textLabel.frame = bounds
    }
    
    override public func prepareForReuse(){
        super.prepareForReuse()
    }
}

@IBDesignable class PaddingLabel: UILabel {
    private var padding: UIEdgeInsets = UIEdgeInsets.zero
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect : CGRect){
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
}
