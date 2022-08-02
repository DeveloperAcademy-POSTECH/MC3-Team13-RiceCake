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
    
    // Gesture Point UIVew 변수
    var tapSmallStrawPoint: UIView!
    var tapBigStrawPoint: UIView!
    var longPressedMilkShakePoint: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 처음 이미지 확대하는 Tap Gesture생성
        let tapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        strawImage.addGestureRecognizer(tapImage)
        
    }
    
    // Gesture 발생되는 UIView 생성함수
    func makeLongPressedMilkShakePoint() {
        longPressedMilkShakePoint = UIView()
        strawView.addSubview(longPressedMilkShakePoint)
        longPressedMilkShakePoint.translatesAutoresizingMaskIntoConstraints = false
        longPressedMilkShakePoint.widthAnchor.constraint(equalToConstant: 50).isActive = true
        longPressedMilkShakePoint.heightAnchor.constraint(equalToConstant: 50).isActive = true
        longPressedMilkShakePoint.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 55).isActive = true
        longPressedMilkShakePoint.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        
        let longPressedMilkShake: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedMilkShake(_:)))
        longPressedMilkShakePoint.addGestureRecognizer(longPressedMilkShake)
        longPressedMilkShakePoint.isUserInteractionEnabled = true
    }
    func makeTapSmallStrawPoint() {
        tapSmallStrawPoint = UIView()
        strawView.addSubview(tapSmallStrawPoint)
        
        tapSmallStrawPoint.translatesAutoresizingMaskIntoConstraints = false
        tapSmallStrawPoint.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tapSmallStrawPoint.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tapSmallStrawPoint.centerYAnchor.constraint(equalTo: self.strawView.centerYAnchor).isActive = true
        tapSmallStrawPoint.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        // Gesture 생성
        let tapSmallStraw: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedSmallStraw(_:)))
        tapSmallStrawPoint.addGestureRecognizer(tapSmallStraw)
        tapSmallStrawPoint.isUserInteractionEnabled = true
    }
    
    func makeTapBigStrawPoint() {
        tapBigStrawPoint = UIView()
        strawView.addSubview(tapBigStrawPoint)
        tapBigStrawPoint.translatesAutoresizingMaskIntoConstraints = false
        tapBigStrawPoint.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tapBigStrawPoint.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tapBigStrawPoint.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        tapBigStrawPoint.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        let otherTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBigStraw(_:)))
        tapBigStrawPoint?.addGestureRecognizer(otherTapGesture)
        tapBigStrawPoint.isUserInteractionEnabled = true
        
    }
    
    // Gesture 발생될때 실행되는 함수정의
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        strawImage.image = UIImage(named: "straw1")
        strawImage.isUserInteractionEnabled = false
        makeLongPressedMilkShakePoint()
    }
    
    @objc func longPressedMilkShake(_ sender: UILongPressGestureRecognizer) {
        strawImage.animationImages = animatedImages(name: "straw", initNum: 1, endNum: 3)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.last
        strawImage.startAnimating()
        self.longPressedMilkShakePoint.isUserInteractionEnabled = false
        makeTapSmallStrawPoint()
    }
    
    @objc func tappedSmallStraw(_ sender: UITapGestureRecognizer) {
        strawImage.stopAnimating()
        self.tapSmallStrawPoint.isUserInteractionEnabled = false
        makeTapBigStrawPoint()
    }
    
    @objc func tappedBigStraw(_ sender: UITapGestureRecognizer) {
        strawImage.animationImages = animatedImages(name: "straw", initNum: 5, endNum: 8)
        strawImage.animationDuration = 3
        strawImage.animationRepeatCount = 0
        strawImage.image = strawImage.animationImages?.first
        strawImage.startAnimating()
        self.tapBigStrawPoint.isUserInteractionEnabled = false
    }
    
    // 애니메이션텍스처 생성함수
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
