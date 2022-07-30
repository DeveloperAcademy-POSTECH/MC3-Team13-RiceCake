//
//  MilkShakeViewController.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/25.
//
import UIKit
import Foundation

class MilkShakeMissionViewController: UIViewController {
    
    @IBOutlet weak var strawView: UIView!
    @IBOutlet weak var strawImage: UIImageView!
    // PlaySound
    var soundBrain = SoundBrain()
    
    // GuideView
    var guideBrain = GuideBrain()
    var guideUiView: UIView!
    var guideImageView: UIImageView!
    
    // Gesture Point UIVew 변수
    var tapGesturePoint: UIView!
    var otehrTapGesturePoint: UIView!
    var longPressedPoint: UIView!
    
    // 좌표값 생성 변수
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GuideVeiw 생성
        guideUiView = guideBrain.getGuideUiView(name: "tap")
        guideImageView = guideBrain.uiViews[guideBrain.guideNumber].guideImageView.imageView
        self.view.addSubview(guideUiView)
        guideUiView.addSubview(guideImageView)
        guideBrain.uiViews[guideBrain.guideNumber].playAnimation()
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 70, yAXis: 70)
        
        // soundPlayTimeReset
        soundBrain.resetSoundTime()
        
        // Gesture생성
        
        let tapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        strawImage.addGestureRecognizer(tapImage)
        
        // Make Gesture Point
        makeGesturePoint()
        
        let (hMult, vMult) = computeMultipliers(angle: 30)
        NSLayoutConstraint(item: tapGesturePoint!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -60).isActive = true
        NSLayoutConstraint(item: tapGesturePoint!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: 115).isActive = true
        NSLayoutConstraint(item: otehrTapGesturePoint!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -120).isActive = true
        NSLayoutConstraint(item: otehrTapGesturePoint!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: -75).isActive = true
        NSLayoutConstraint(item: longPressedPoint!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -140).isActive = true
        NSLayoutConstraint(item: longPressedPoint!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: 15).isActive = true
        
    }
    // View Drage 위한 Circle 생성
    func makeGesturePoint() {
        tapGesturePoint = UIView()
        tapGesturePoint.translatesAutoresizingMaskIntoConstraints = false
        tapGesturePoint.backgroundColor = .none
        strawView.addSubview(tapGesturePoint)
        tapGesturePoint.widthAnchor.constraint(equalToConstant: 25).isActive = true
        tapGesturePoint.heightAnchor.constraint(equalToConstant: 25).isActive = true
        tapGesturePoint.isUserInteractionEnabled = true
        
        otehrTapGesturePoint = UIView()
        otehrTapGesturePoint.translatesAutoresizingMaskIntoConstraints = false
        otehrTapGesturePoint.backgroundColor = .none
        strawView.addSubview(otehrTapGesturePoint)
        otehrTapGesturePoint.widthAnchor.constraint(equalToConstant: 25).isActive = true
        otehrTapGesturePoint.heightAnchor.constraint(equalToConstant: 25).isActive = true
        otehrTapGesturePoint.isUserInteractionEnabled = true
        
        longPressedPoint = UIView()
        longPressedPoint.translatesAutoresizingMaskIntoConstraints = false
        longPressedPoint.backgroundColor = .none
        strawView.addSubview(longPressedPoint)
        longPressedPoint.widthAnchor.constraint(equalToConstant: 25).isActive = true
        longPressedPoint.heightAnchor.constraint(equalToConstant: 25).isActive = true
        longPressedPoint.isUserInteractionEnabled = true
    }
    
    // GesturePoint Layout 지정함수
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tapGesturePoint.layoutIfNeeded()
        tapGesturePoint.layer.cornerRadius = 0.7 * tapGesturePoint.frame.height
        otehrTapGesturePoint.layoutIfNeeded()
        otehrTapGesturePoint.layer.cornerRadius = 0.7 * otehrTapGesturePoint.frame.height
        longPressedPoint.layoutIfNeeded()
        longPressedPoint.layer.cornerRadius = 0.7 * otehrTapGesturePoint.frame.height
    }
    
    // Circle 원형틀 생성함수
    func computeMultipliers(angle: CGFloat) -> (CGFloat, CGFloat) {
        let radians = angle * .pi / 180
        
        let hall = (1.0 + cos(radians)) / 2
        let vowl = (1.0 - sin(radians)) / 2
        
        return (hall, vowl)
    }
    
    // Gesture 발생될때 실행되는 함수정의
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        strawImage.image = UIImage(named: "straw1")
        if soundBrain.soundPlayTime == 0 {
            soundBrain.playSound(name: "Gesture0")
        }
        let longPressedGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedStraw(_:)))
        longPressedPoint.addGestureRecognizer(longPressedGesture)
        guideImageView.image = guideBrain.uiViews[guideBrain.guideNumber].changeImage(name: "longPressed")
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 60, yAXis: 90)
    }
    
    @objc func longPressedStraw(_ sender: UILongPressGestureRecognizer) {
        if soundBrain.soundPlayTime == 1 {
            soundBrain.playSound(name: "Gesture2")
        }
        strawImage.animationImages = animatedImages(name: "straw", initNum: 1, endNum: 3)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.last
        strawImage.startAnimating()
        let tapGreenCircle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedFirstPoint(_:)))
        tapGesturePoint?.addGestureRecognizer(tapGreenCircle)
        guideImageView.image = guideBrain.uiViews[guideBrain.guideNumber].changeImage(name: "tap")
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 150, yAXis: 220)
    }
    
    @objc func tappedFirstPoint(_ sender: UITapGestureRecognizer) {
        if soundBrain.soundPlayTime == 2 {
            soundBrain.playSound(name: "Gesture0")
        }
        strawImage.stopAnimating()
        let otherTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedSecondPoint(_:)))
        otehrTapGesturePoint?.addGestureRecognizer(otherTapGesture)
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 80, yAXis: 20)
        // PanGesture 구현
//        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panStraw(_:)))
    }
    
    @objc func tappedSecondPoint(_ sender: UITapGestureRecognizer) {
        if soundBrain.soundPlayTime == 3 {
            soundBrain.playSound(name: "Gesture0")
            guideBrain.uiViews[guideBrain.guideNumber].stopAnimation()
        }
        strawImage.animationImages = animatedImages(name: "straw", initNum: 5, endNum: 8)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.first
        strawImage.startAnimating()
    }
    
    // 이미지텍스처 생성함수
    func animatedImages(name: String, initNum: Int, endNum: Int) -> [UIImage] {
        var images = [UIImage]()
        for count in initNum...endNum {
            if let image = UIImage(named: "\(name)\(count)") {
                images.append(image)
            }
        }
        return images
    }
}
