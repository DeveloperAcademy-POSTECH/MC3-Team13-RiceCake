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
    
    // Circle UIVew 변수
    var littleCircle: UIView!
    var twinkleCircle: UIView!
    
    // 좌표값 생성 변수
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture생성
        let longPressedGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedStarw(_:)))
        strawImage.addGestureRecognizer(longPressedGesture)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        strawImage.addGestureRecognizer(tapGesture)
        
        makeCircle()
        
        let (hMult, vMult) = computeMultipliers(angle: 30)
        NSLayoutConstraint(item: littleCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -60).isActive = true
        NSLayoutConstraint(item: littleCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: 110).isActive = true
        NSLayoutConstraint(item: twinkleCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -120).isActive = true
        NSLayoutConstraint(item: twinkleCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: -90).isActive = true
        
    }
    // View Drage 위한 Circle 생성
    func makeCircle() {
        littleCircle = UIView()
        littleCircle.translatesAutoresizingMaskIntoConstraints = false
        littleCircle.backgroundColor = .green
        strawView.addSubview(littleCircle)
        littleCircle.widthAnchor.constraint(equalToConstant: 25).isActive = true
        littleCircle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        littleCircle.isUserInteractionEnabled = true
        
        twinkleCircle = UIView()
        twinkleCircle.translatesAutoresizingMaskIntoConstraints = false
        twinkleCircle.backgroundColor = .blue
        strawView.addSubview(twinkleCircle)
        twinkleCircle.widthAnchor.constraint(equalToConstant: 25).isActive = true
        twinkleCircle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        littleCircle.isHidden = true
        twinkleCircle.isHidden = true
    }
    
    // Circle Layout 지정함수
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        littleCircle.layoutIfNeeded()
        littleCircle.layer.cornerRadius = 0.5 * littleCircle.frame.height
        twinkleCircle.layoutIfNeeded()
        twinkleCircle.layer.cornerRadius = 0.5 * twinkleCircle.frame.height
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
    }
    @objc func longPressedStraw(_ sender: UILongPressGestureRecognizer) {
        strawImage.animationImages = animatedImages(name: "straw", initNum: 1, endNum: 3)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.last
        strawImage.startAnimating()
        let otherTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedStraw(_:)))
        littleCircle?.addGestureRecognizer(otherTapGesture)
        littleCircle.isHidden = false
    }
    
    @objc func tappedStraw(_ sender: UITapGestureRecognizer) {
        twinkleCircle.isHidden = false
        strawImage.stopAnimating()
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panStraw(_:)))
        littleCircle?.addGestureRecognizer(panGesture)
    }
    
    @objc func panStraw(_ sender: UIPanGestureRecognizer) {
        littleCircle.isHidden = false
        twinkleCircle.isHidden = false
        switch sender.state {
        case .began:
            initialCenter = littleCircle.center
        case .changed:
            let translation = sender.translation(in: view)
            
            littleCircle.center = CGPoint(x: initialCenter.x + translation.x,
                                          y: initialCenter.y + translation.y)
        case .ended,
                .cancelled:
            littleCircle.isHidden = true
            twinkleCircle.isHidden = true
            strawImage.animationImages = animatedImages(name: "straw", initNum: 5, endNum: 8)
            strawImage.animationDuration = 3
            strawImage.animationRepeatCount = 0
            strawImage.image = strawImage.animationImages?.first
            strawImage.startAnimating()
        default:
            break
        }
    }
    
    // 이미지텍스처 생성함수
    func animatedImages(name: String, initNum:Int, endNum:Int) -> [UIImage] {
        var images = [UIImage]()
        for count in initNum...endNum {
            if let image = UIImage(named: "\(name)\(count)") {
                images.append(image)
            }
        }
        return images
    }
}
