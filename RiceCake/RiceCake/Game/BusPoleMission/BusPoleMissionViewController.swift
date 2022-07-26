//
//  BusPoleMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/18.
//

import UIKit

class BusPoleMissionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var busPoleBackground: UIImageView!
    @IBOutlet weak var firstBusHandle: UIImageView!
    @IBOutlet weak var secondBusHandle: UIImageView!
    @IBOutlet weak var frontBusPole: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    @IBOutlet weak var childHoldHand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 각 이미지에 gestureRecognizer 적용
        let firstBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
        firstBusHandle.addGestureRecognizer(firstBusHandleTapGesture)
        
        let secondBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
        secondBusHandle.addGestureRecognizer(secondBusHandleTapGesture)
        
        let busPoleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
        frontBusPole.tag = 1
        frontBusPole.addGestureRecognizer(busPoleTapGesture)
        
        let busPoleLongPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedBusPole(_:)))
        frontBusPole.addGestureRecognizer(busPoleLongPressGesture)
 
    }
    
    // tap gesture에 반응할 함수
    @objc func tappedHandle(_ sender: UITapGestureRecognizer) {
        childHandUp()
        childHandDown()
        sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
    }
    
    // long press gesture에 반응할 함수
    @objc func longPressedBusPole(_ sender: UILongPressGestureRecognizer) {
        childHandUp()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            self.childLeftHand.isHidden = true
            self.childHoldHand.isHidden = false
        }
    }
    
    // childeLeftHand Up & Down 애니메이션
    func childHandUp() {
        UIView.animate(withDuration: 0.7, animations: {
            self.childLeftHand.center.y -= self.view.bounds.height/4
        }, completion: nil)
    }
    func childHandDown() {
        UIView.animate(withDuration: 0.7, delay: 0.7, animations: {
            self.childLeftHand.center.y += self.view.bounds.height/4
        }, completion: nil)
    }
    
    // childLeftHand를 제외한 전체 이미지 이동 및 애니메이션
    func viewMoved(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let images: [UIImageView] = [busPoleBackground, firstBusHandle, secondBusHandle, frontBusPole, childHoldHand]
        
        for image in images {
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
                image.center.x -= self.view.bounds.width
            }, completion: nil)
        }
    }
}
