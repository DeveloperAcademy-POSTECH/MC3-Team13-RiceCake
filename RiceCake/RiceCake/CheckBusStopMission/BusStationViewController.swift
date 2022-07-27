//
//  CheckBusStopMission.swift
//  RiceCake
//
//  Created by 김승훈 on 2022/07/26.
//

import Foundation
import UIKit


class BusStationViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    @IBOutlet weak var buttonImage: UIImageView!
//    @IBOutlet weak var buttonImage2: UIImageView!
    
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonImage2: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    var pinch = UIPinchGestureRecognizer()
    var recognizerscale:CGFloat = 1.0
    var maxscale:CGFloat = 2.0
    var minscale:CGFloat = 1.0
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    pinch = UIPinchGestureRecognizer(target: self, action: #selector(dopinch(_:)))
        self.view.addGestureRecognizer(pinch)

    
    
   
    
    
let config = UIImage.SymbolConfiguration(pointSize: 72)
    _ = UIImage(systemName: "CheckBusMission.rightseat", withConfiguration: config)
    
    let config2 = UIImage.SymbolConfiguration(pointSize: 72)
    _ = UIImage(systemName: "CheckBusMission.leftseat", withConfiguration: config2)
    
    
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftTapPressed(_:)))
            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightTapPressed(_:)))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
    
    let leftTapGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftTapPressed(_:)))
    buttonImage.addGestureRecognizer(leftTapGesture)
    
    let rightTapGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightTapPressed(_:)))
    buttonImage2.addGestureRecognizer(rightTapGesture)
    }
   
    // Animation
    
    @objc func leftTapPressed(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage.center.x -= self.view.bounds.height/1.5
        }, completion: nil)
        print("야 왼쪽사람 저리좀 비켜봐!.")
    }

    @objc func rightTapPressed(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage2.center.x += self.view.bounds.height/1.5
        }, completion: nil)
        print("야 오른쪽사람 저리좀 비켜봐!.")
    }
    
    @objc func tappedHandle(_ sender: UISwipeGestureRecognizer) {
        Leftperson()
        Rightperson()
//        sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
    }
    
    
    func Leftperson() {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage.center.y -= self.view.bounds.height/1.5
        }, completion: nil)
    }
    func Rightperson() {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage2.center.y += self.view.bounds.height/1.5
        }, completion: nil)
    }
    
   

    @objc func respondToSwipeGestureMulti(_ gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                buttonImage.image
                buttonImage2.image
                
                // 발생한 이벤트가 각 방향의 스와이프 이벤트라면 해당 이미지 뷰를 초록색 화살표 이미지로 변경
                switch swipeGesture.direction {
                    
                    case UISwipeGestureRecognizer.Direction.left:
                    buttonImage.image
                    case UISwipeGestureRecognizer.Direction.right:
                    buttonImage2.image
                    default:
                        break
                }
            }
        }

@objc func dopinch(_ pinch: UIPinchGestureRecognizer) {
    
    guard background != nil else {return}
    
    if pinch.state == .began || pinch.state == .changed{
        if(recognizerscale < maxscale && pinch.scale > 1.0){
            background.transform = (background.transform).scaledBy(x: pinch.scale, y: pinch.scale)
            
            recognizerscale *= pinch.scale
            pinch.scale = 1.0
    }
        else if(recognizerscale > minscale && pinch.scale < 1.0){
            background.transform = (background.transform).scaledBy(x: pinch.scale, y: pinch.scale)
            recognizerscale *= pinch.scale
            pinch.scale = 1.0
        }
//        sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
}

}
}









//    // 각 이미지에 gestureRecognizer 적용
//    let firstBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//    firstBusHandle.addGestureRecognizer(firstBusHandleTapGesture)
//
//    let secondBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//    secondBusHandle.addGestureRecognizer(secondBusHandleTapGesture)
//
//    let busPoleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
//    frontBusPole.tag = 1
//    frontBusPole.addGestureRecognizer(busPoleTapGesture)
//
//    let busPoleLongPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedBusPole(_:)))
//    frontBusPole.addGestureRecognizer(busPoleLongPressGesture)


//// tap gesture에 반응할 함수
//@objc func tappedHandle(_ sender: UITapGestureRecognizer) {
//    childHandUp()
//    childHandDown()
//    sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
//}
//
//// long press gesture에 반응할 함수
//@objc func longPressedBusPole(_ sender: UILongPressGestureRecognizer) {
//    childHandUp()
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
//        self.childLeftHand.isHidden = true
//        self.childHoldHand.isHidden = false
//    }
//}

