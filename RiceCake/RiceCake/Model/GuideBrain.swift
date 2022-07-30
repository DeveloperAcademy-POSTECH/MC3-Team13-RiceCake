//
//  GuideBrain.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/30.
//

import Foundation
import UIKit

class GuideBrain {
    var guideNumber = 0
    
    var uiViews = [
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "tap")),     imageViewWidth: 100, imageViewHeight: 100), uiViewName: "tap"),
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "doubletap")), imageViewWidth: 100, imageViewHeight: 100), uiViewName: "doubletap"),
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "longPressed")), imageViewWidth: 100, imageViewHeight: 100), uiViewName: "longPressed"),
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "pan")), imageViewWidth: 100, imageViewHeight: 100), uiViewName: "pan"),
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "pinch")), imageViewWidth: 100, imageViewHeight: 100), uiViewName: "pinch"),
    GuideUiview(uiView: UIView(), guideImageView: GuideImageView(imageView: UIImageView(image: UIImage(named: "swipe")), imageViewWidth: 100, imageViewHeight: 100), uiViewName: "swipe")]
    
    func getGuideUiView(name: String) -> UIView {
        self.guideNumber = uiViews.firstIndex(where: {$0.uiViewName == name}) ?? 0
        let uiViewNumber = uiViews.firstIndex(where: {$0.uiViewName == name}) ?? 0
        return uiViews[uiViewNumber].uiView
    }
    
}
