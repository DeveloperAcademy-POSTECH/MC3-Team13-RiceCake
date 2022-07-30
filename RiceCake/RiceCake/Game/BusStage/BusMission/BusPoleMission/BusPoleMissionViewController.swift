//
//  BusPoleMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/18.
//

import UIKit
import AudioToolbox

class BusPoleMissionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // PlaySound
    var soundBrain = SoundBrain()
    
    // GuideView
    var guideBrain = GuideBrain()
    var guideUiView: UIView!
    var guideImageView: UIImageView!
    
    @IBOutlet weak var busPoleBackground: UIImageView!
    @IBOutlet weak var firstBusHandle: UIImageView!
    @IBOutlet weak var secondBusHandle: UIImageView!
    @IBOutlet weak var frontBusPole: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    @IBOutlet weak var childHoldHand: UIImageView!
    
    var busPoleTapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GuideView 생성
        guideUiView = guideBrain.getGuideUiView(name: "tap")
        guideImageView = guideBrain.uiViews[guideBrain.guideNumber].guideImageView.imageView
        self.view.addSubview(guideUiView)
        guideUiView.addSubview(guideImageView)
        guideBrain.uiViews[guideBrain.guideNumber].playAnimation()
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 75, yAXis: 20)
        
        // soundPlayTimeReset
        soundBrain.resetSoundTime()
        
        // 각 이미지에 gestureRecognizer 적용
        let firstBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
        firstBusHandle.addGestureRecognizer(firstBusHandleTapGesture)
        
        let secondBusHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandleSecond(_:)))
        secondBusHandle.addGestureRecognizer(secondBusHandleTapGesture)
        
        busPoleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedHandle(_:)))
        frontBusPole.tag = 1
        frontBusPole.addGestureRecognizer(busPoleTapGesture)
        
        let busPoleLongPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedBusPole(_:)))
        frontBusPole.addGestureRecognizer(busPoleLongPressGesture)
 
    }
    
    // tap gesture에 반응할 함수
    @objc func tappedHandle(_ sender: UITapGestureRecognizer) {
        if soundBrain.soundPlayTime == 0 {
            soundBrain.playSound(name: "Gesture0")
            guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 75, yAXis: 80)
        }
        busPoleTapGesture.isEnabled = false
        childHandUp()
        childHandDown()
        sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
    }
    //MARK: GestureGuide 위치조정을 위해서 Tap함수 하나 더 생성
    @objc func tappedHandleSecond(_ sender: UITapGestureRecognizer){
        if soundBrain.soundPlayTime == 1 {
            soundBrain.playSound(name: "Gesture0")
            guideImageView.image = guideBrain.uiViews[guideBrain.guideNumber].changeImage(name: "longPressed")
            guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 75, yAXis: 110)
        }
        busPoleTapGesture.isEnabled = false
        childHandUp()
        childHandDown()
        sender.view?.tag ?? 0 != 1 ? viewMoved(true) : ()
    }
    // long press gesture에 반응할 함수
    @objc func longPressedBusPole(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            busPoleTapGesture.isEnabled = false
            childHandUp()
            if soundBrain.soundPlayTime == 2 {
                soundBrain.playSound(name: "Gesture2")
            }
            guideBrain.uiViews[guideBrain.guideNumber].stopAnimation()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.childLeftHand.isHidden = true
                self.childHoldHand.isHidden = false
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                NotificationCenter.default.post(name: .endBusPoleMission, object: nil)
            }
        }
    }
    
    // childeLeftHand Up & Down 애니메이션
    func childHandUp() {
        UIView.animate(withDuration: 0.7, animations: {
            self.childLeftHand.center.y -= self.view.bounds.height/4
        }, completion: nil)
    }
    func childHandDown() {
        UIView.animate(withDuration: 0.7, delay: 0.7) {
            self.childLeftHand.center.y += self.view.bounds.height/4
        } completion: { _ in
            self.busPoleTapGesture.isEnabled = true
        }

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
