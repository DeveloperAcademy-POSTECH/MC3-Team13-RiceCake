//
//  CheckBusStopMission.swift
//  RiceCake
//
//  Created by 김승훈 on 2022/07/26.
//

import Foundation
import UIKit

class BusStationViewController: UIViewController, UIGestureRecognizerDelegate {

    //노드 @IBOutlet 연결
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonImage2: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    //Pinch gesture scale 값 설정
    var pinch = UIPinchGestureRecognizer()
    var recognizerscale:CGFloat = 1.0
    var maxscale:CGFloat = 2.0
    var minscale:CGFloat = 1.0
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    //Pinch gesture 연결
    pinch = UIPinchGestureRecognizer(target: self, action: #selector(dopinch(_:)))
        self.view.addGestureRecognizer(pinch)

    //swipe gesture 연결
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
   
    //swipe gesture Animation 값 설정
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
    }
    
    //swipe 사람 애니메이션 Animation 값 설정
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
    //Pinchgesture Animation 값 설정
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
        }
    }
}
