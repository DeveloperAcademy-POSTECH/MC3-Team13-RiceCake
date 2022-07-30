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
    var greenCircle: UIView!
    var blueCircle: UIView!
    
    // 좌표값 생성 변수
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture생성
        let longPressedGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedStraw(_:)))
        strawImage.addGestureRecognizer(longPressedGesture)
        
        let tapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        strawImage.addGestureRecognizer(tapImage)
        
        
        makeCircle()
        
        let (hMult, vMult) = computeMultipliers(angle: 30)
        NSLayoutConstraint(item: greenCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -60).isActive = true
        NSLayoutConstraint(item: greenCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: 110).isActive = true
        NSLayoutConstraint(item: blueCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -120).isActive = true
        NSLayoutConstraint(item: blueCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: -90).isActive = true
        
    }
    // View Drage 위한 Circle 생성
    func makeCircle() {
        greenCircle = UIView()
        greenCircle.translatesAutoresizingMaskIntoConstraints = false
        greenCircle.backgroundColor = .green
        strawView.addSubview(greenCircle)
        greenCircle.widthAnchor.constraint(equalToConstant: 25).isActive = true
        greenCircle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        greenCircle.isUserInteractionEnabled = true
        
        blueCircle = UIView()
        blueCircle.translatesAutoresizingMaskIntoConstraints = false
        blueCircle.backgroundColor = .blue
        strawView.addSubview(blueCircle)
        blueCircle.widthAnchor.constraint(equalToConstant: 25).isActive = true
        blueCircle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        blueCircle.isUserInteractionEnabled = true
        
        greenCircle.isHidden = true
        blueCircle.isHidden = true
    }
    
    // Circle Layout 지정함수
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        greenCircle.layoutIfNeeded()
        greenCircle.layer.cornerRadius = 0.5 * greenCircle.frame.height
        blueCircle.layoutIfNeeded()
        blueCircle.layer.cornerRadius = 0.5 * blueCircle.frame.height
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
        let tapGreenCircle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedGreenCircle(_:)))
        greenCircle?.addGestureRecognizer(tapGreenCircle)
        greenCircle.isHidden = false
    }
    
    @objc func tappedGreenCircle(_ sender: UITapGestureRecognizer) {
        blueCircle.isHidden = false
        greenCircle.isHidden = true
        strawImage.stopAnimating()
        let otherTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBlueCircle(_:)))
        blueCircle?.addGestureRecognizer(otherTapGesture)
        // PanGesture 구현
//        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panStraw(_:)))
    }
    
    @objc func tappedBlueCircle(_ sender: UITapGestureRecognizer) {
        greenCircle.isHidden = true
        blueCircle.isHidden = true
        strawImage.animationImages = animatedImages(name: "straw", initNum: 5, endNum: 8)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.first
        strawImage.startAnimating()
    }
    // PanGesture 구현
    
//    @objc func panStraw(_ sender: UIPanGestureRecognizer) {
//        greenCircle.isHidden = false
//        blueCircle.isHidden = false
//        switch sender.state {
//        case .began:
//            initialCenter = greenCircle.center
//        case .changed:
//            let translation = sender.translation(in: view)
//
//            greenCircle.center = CGPoint(x: initialCenter.x + translation.x,
//                                          y: initialCenter.y + translation.y)
//        case .ended, .cancelled:
//            greenCircle.isHidden = true
//            blueCircle.isHidden = true
//            strawImage.animationImages = animatedImages(name: "straw", initNum: 5, endNum: 8)
//            strawImage.animationDuration = 3
//            strawImage.animationRepeatCount = 0
//            strawImage.image = strawImage.animationImages?.first
//            strawImage.startAnimating()
//        default:
//            break
//        }
//    }
    
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
