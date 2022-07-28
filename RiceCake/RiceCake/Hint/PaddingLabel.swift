//
//  PaddingLabel.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/28.
//

import UIKit

// Padding 값 적용이 가능한 UILabel class
// https://gist.github.com/konnnn/d43af3bd525bb4c58f5c29fb14575b0d#file-uilabel-padding-swift-L66
class PaddingLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        
        return contentSize
    }
    
}
