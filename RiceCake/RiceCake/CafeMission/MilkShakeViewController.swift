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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        strawUpAndDown()
    }
    
    @objc func panPressedStarw(_ sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: {
            self.gestureTest.image = UIImage(named: "animation4")
        }, completion: nil)
    }
    func strawDownAction() {
        self.gestureTest.image = UIImage(named: "animation3")
        print("down")
        self.gestureTest.isHidden = false
    }
    
    // MARK: Image Asset Chanage방식이 되지않아서 도형을 넣어서 Position값을 수정해야한다
    func strawUpAndDown() {
        UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: { [weak self] in
            guard let self = self else { return }
            self.gestureTest.image = UIImage(named: "animation4")
            print("UpAndDown")
        }, completion: {(_) in
            self.gestureTest.image = UIImage(named: "animation3")
            self.strawUpAndDown()
            self.strawDownAction()
        })
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
