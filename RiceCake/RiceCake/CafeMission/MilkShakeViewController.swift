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
    
    var littleCircle: UIView!
    var twinkleCircle: UIView!
    
    var initialCenter = CGPoint()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressedGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedStarw(_:)))
        strawImage.addGestureRecognizer(longPressedGesture)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        strawImage.addGestureRecognizer(tapGesture)
        
        
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
                
                let (hMult, vMult) = computeMultipliers(angle: 30)
                
                // position the little green circle using a multiplier on the right and bottom
                NSLayoutConstraint(item: littleCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -60).isActive = true
                NSLayoutConstraint(item: littleCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: 110).isActive = true
            NSLayoutConstraint(item: twinkleCircle!, attribute: .centerX, relatedBy: .equal, toItem: strawView!, attribute: .trailing, multiplier: hMult, constant: -120).isActive = true
            NSLayoutConstraint(item: twinkleCircle!, attribute: .centerY, relatedBy: .equal, toItem: strawView!, attribute: .bottom, multiplier: vMult, constant: -90).isActive = true
        littleCircle.isHidden = true
        twinkleCircle.isHidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        littleCircle.layoutIfNeeded()
        littleCircle.layer.cornerRadius = 0.5 * littleCircle.frame.height
        twinkleCircle.layoutIfNeeded()
        twinkleCircle.layer.cornerRadius = 0.5 * twinkleCircle.frame.height
    }
    func computeMultipliers(angle: CGFloat) -> (CGFloat, CGFloat) {
            let radians = angle * .pi / 180
            
            let hall = (1.0 + cos(radians)) / 2
            let vowl = (1.0 - sin(radians)) / 2
            
            return (hall, vowl)
        }
    // x,y 좌표찾는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
    }
    // Gesture 함수 정의
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        strawImage.image = UIImage(named: "straw1")
        print("Tapped")
    }
    @objc func longPressedStarw(_ sender: UILongPressGestureRecognizer) {
        print("LongPressed")
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
        print("strawTapped")
        let panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panStraw(_:)))
        littleCircle?.addGestureRecognizer(panGesture)
    }
    
    @objc func panStraw(_ sender: UIPanGestureRecognizer) {
        print("paned")
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
            print("CircleMoved")
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
    // MARK: Image Asset Chanage방식이 되지않아서 다른방식으로 애니메이션 제작
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
