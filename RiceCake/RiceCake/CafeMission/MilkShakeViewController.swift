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
//
//        let secondBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//        secondBusHandle.addGestureRecognizer(secondBusHandleTapGesture)
//
//        let busPoleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//        frontBusPole.tag = 1
//        frontBusPole.addGestureRecognizer(busPoleTapGesture)
//
//        let busPoleLongPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedBusPole(_:)))
//        frontBusPole.addGestureRecognizer(busPoleLongPressGesture)
    }
    
    //MARK: Animation 함수 넣기
    
    @objc func tappedStraw(_ sender: UITapGestureRecognizer) {
        gestureTest.image = UIImage(named: "animation2")
        print("Tapped")
    }
    
    @objc func longPressedStarw(_ sender: UILongPressGestureRecognizer) {
        print("LongPressed")
    }
}
