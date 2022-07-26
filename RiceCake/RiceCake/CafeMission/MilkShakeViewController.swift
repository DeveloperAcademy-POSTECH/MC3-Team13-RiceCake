//
//  MilkShakeViewController.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/25.
//
import UIKit
import Foundation

class MilkShakeMissionViewController: UIViewController {
    
    @IBOutlet weak var gestureTest: UIImageView!
    
    @IBOutlet weak var animationView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.alpha = 0

        let longPressedGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedStarw(_:)))
        gestureTest.addGestureRecognizer(longPressedGesture)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedStraw(_:)))
        gestureTest.addGestureRecognizer(tapGesture)
//        // 각 이미지에 gestureRecognizer 적용
//        let firstBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//        firstBusHandle.addGestureRecognizer(firstBusHandleTapGesture)
    }
    //MARK: Animation 함수 넣기
    @objc func tappedStraw(_ sender: UITapGestureRecognizer) {
        gestureTest.image = UIImage(named: "animation2")
        print("Tapped")
    }
    @objc func longPressedStarw(_ sender: UILongPressGestureRecognizer) {
        print("LongPressed")
        gestureTest.animationImages = animatedImages(for: "StrawAction")
        gestureTest.animationDuration = 1.5
        gestureTest.animationRepeatCount = 5
        gestureTest.image = gestureTest.animationImages?.first
        gestureTest.startAnimating()
    }
    
    @objc func panPressedStarw(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: {
            self.gestureTest.image = UIImage(named: "animation4")
        }, completion: nil)
    }
    
    // MARK: Image Asset Chanage방식이 되지않아서 다른방식으로 애니메이션 제작
    
    func animatedImages(for name: String) -> [UIImage] {
        
        var count = 3
        var images = [UIImage]()
        
        while let image = UIImage(named: "animation\(count)") {
            images.append(image)
            count += 1
        }
        return images
    }
    // 빨대를 들어가는 액체 CA레이어로 만들어서 Image를 그대로 가지든가 백터이미지를 그렷나 포지션 값을 조절가능
    // Opacity 조절해서 2장 이미지
}
//                       // 손이 랜덤한 높이로 올라갔다 내려오는 함수
//                       func childHandUpAndDown() {
//                           UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut, .autoreverse], animations: { [weak self] in
//                               guard let self = self else { return }
//                               self.childLeftHand.center.y -= self.randomY()
//                           }, completion: { (done) in
//                               self.setupChildHand()
//                               self.childHandUpAndDown()
//                           })
//                       }
