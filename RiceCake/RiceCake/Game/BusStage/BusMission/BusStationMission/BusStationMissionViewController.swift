//
//  CheckBusStopMission.swift
//  RiceCake
//
//  Created by 김승훈 on 2022/07/26.
//

import UIKit
import AudioToolbox

class BusStationMissionViewController: UIViewController, UIGestureRecognizerDelegate {
    // PlaySound
    var soundBrain = SoundBrain()
    
    // GuideView
    var guideBrain = GuideBrain()
    var guideUiView: UIView!
    var guideImageView: UIImageView!
    
    // 노드 @IBOutlet 연결
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonImage2: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    // Pinch gesture scale 값 설정
    var pinchRecognizer = UIPinchGestureRecognizer()
    var recognizerScale: CGFloat = 1.0
    var maxScale: CGFloat = 2.0
    var minScale: CGFloat = 1.0
    
    private var isFinishedLeftSwipe: Bool = false
    private var isFinishedRightSwipe: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GuideView 생성
        guideUiView = guideBrain.getGuideUiView(name: "swipe")
        guideImageView = guideBrain.uiViews[guideBrain.guideNumber].guideImageView.imageView
        self.view.addSubview(guideUiView)
        guideUiView.addSubview(guideImageView)
        guideBrain.uiViews[guideBrain.guideNumber].playAnimation()
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 25, yAXis: 200)
        
        // soundPlayTimeReset
        soundBrain.resetSoundTime()
        
        // Pinch gesture 연결
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchHappened(_:)))
        self.view.addGestureRecognizer(pinchRecognizer)
        
        // Swipe gesture 연결
        let swipeToLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToLeftHappened(_:)))
        swipeToLeftRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeToLeftRecognizer)
        
        let swipeToRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiftToRightHappend(_:)))
        swipeToRightRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeToRightRecognizer)
    }
    
    // Swipe Gesture Animation 값 설정
    @objc func swipeToLeftHappened(_ sender: UISwipeGestureRecognizer) {
        if soundBrain.soundPlayTime == 0 {
            soundBrain.playSound(name: "Gesture5")
        }
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 120, yAXis: 200)
        movePeopleToLeft()
        isFinishedLeftSwipe = true
    }
    @objc func swiftToRightHappend(_ sender: UISwipeGestureRecognizer) {
        if soundBrain.soundPlayTime == 1 {
            soundBrain.playSound(name: "Gesture5")
        }
        guideImageView.image = guideBrain.uiViews[guideBrain.guideNumber].changeImage(name: "pinch")
        guideBrain.uiViews[guideBrain.guideNumber].changePosition(xAxis: 80, yAXis: 130)
        
        movePeopleToRight()
        isFinishedRightSwipe = true
    }
    // Pinch Gesture Animation 값 설정
    @objc func pinchHappened(_ pinch: UIPinchGestureRecognizer) {
        guard background != nil else { return }
        if isFinishedLeftSwipe && isFinishedRightSwipe {
            if pinch.state == .began || pinch.state == .changed {
                if pinch.scale > 1.0 && recognizerScale < maxScale {
                    background.transform = (background.transform).scaledBy(x: pinch.scale, y: pinch.scale)
                    recognizerScale *= pinch.scale
                    pinch.scale = 1.0
                } else if pinch.scale < 1.0 && recognizerScale > minScale {
                    background.transform = (background.transform).scaledBy(x: pinch.scale, y: pinch.scale)
                    recognizerScale *= pinch.scale
                    pinch.scale = 1.0
                } else if recognizerScale > 1.90 {
                    // MARK: 미션 성공
                    if soundBrain.soundPlayTime == 2 {
                        soundBrain.playSound(name: "Gesture4")
                        guideBrain.uiViews[guideBrain.guideNumber].stopAnimation()
                    }
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        NotificationCenter.default.post(name: .drawBusBellHint, object: nil)
                    }
                }
            }
        }
    }
    // 사람 Animation 값 설정
    func movePeopleToLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage.center.x -= self.view.bounds.height/1.5
        }, completion: nil)
    }
    func movePeopleToRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonImage2.center.x += self.view.bounds.height/1.5
        }, completion: nil)
    }
}
