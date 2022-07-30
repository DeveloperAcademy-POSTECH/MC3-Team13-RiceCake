//
//  GuideView.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/30.
//

import Foundation
import UIKit

class GuideUiview {
    let uiView: UIView
    var guideImageView: GuideImageView
    let uiViewName: String
    init(uiView: UIView, guideImageView: GuideImageView, uiViewName: String ) {
        self.uiView = uiView
        self.guideImageView = guideImageView
        self.uiViewName = uiViewName
    }
    
    // PlayAnimation UIView
    func playAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .repeat, animations: {
            self.uiView.alpha = 0.0
        }, completion: { _ in
            self.uiView.alpha = 1.0
        })
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseIn, animations: {
            self.uiView.isHidden = true
        }, completion: nil)
    }
    
    func changePosition(xAxis: CGFloat, yAXis: CGFloat) {
        self.uiView.frame.origin.x = xAxis
        self.uiView.frame.origin.y = yAXis
    }
    
    func changeImage(name: String) -> UIImage? {
        self.guideImageView.imageView = UIImageView(image: UIImage(named: name))
        let changeImageView = self.guideImageView.imageView.image ?? UIImage(named: "tap")
        return changeImageView
    }
    
}

class GuideImageView {
    var imageView: UIImageView
    var imageViewWidth: Double
    var imageViewHeight: Double
    
    init(imageView: UIImageView, imageViewWidth: Double = 100.0, imageViewHeight: Double = 100.0) {
        self.imageView = imageView
        self.imageViewWidth = imageViewWidth
        self.imageViewHeight = imageViewHeight
        self.imageView.frame.size.width = imageViewWidth
        self.imageView.frame.size.height = imageViewHeight
    }
}
