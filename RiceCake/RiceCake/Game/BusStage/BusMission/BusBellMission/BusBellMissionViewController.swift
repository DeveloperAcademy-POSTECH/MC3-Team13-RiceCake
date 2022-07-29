//
//  BusBellMissionViewController.swift
//  RiceCake
//
//  Created by 조은비 on 2022/07/26.
//

import UIKit
import AVFoundation

class BusBellMissionViewController: UIViewController {
    
    @IBOutlet weak var busBellMissionBackground: UIImageView!
    @IBOutlet weak var busBell: UIImageView!
    @IBOutlet weak var tapRecognizer: UIImageView!
    @IBOutlet weak var tappedBusBell: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    
    // 3가지 childLeftHand의 랜덤한 높이를 지정하기 위한 배열
    let childLeftHandPisitions: [CGFloat] = [1, 1.1, 1.22]
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    var avPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let busBellTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBell(_:)))
        tapRecognizer.addGestureRecognizer(busBellTapGesture)
        tappedBusBell.isHidden = true
        tapRecognizer.isHidden = true
        
        childHandUpAndDown()
        audioAsset()
    }
    
    // 오디오 세팅
    func audioAsset() {
        guard let sound = NSDataAsset(name: "bellSound") else {
            print("Asset load error")
            return
        }
        do {
            try self.avPlayer = AVAudioPlayer(data: sound.data)
            self.avPlayer.prepareToPlay()
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    // 손 위치 초기 설정
    func setupChildHand() {
        self.childLeftHand.center.y = self.view.bounds.height / 0.5
        self.tappedBusBell.isHidden = true
        self.tapRecognizer.isHidden = true
    }
    
    // 애니메이션 동작 멈추는 함수
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    // 미션 성공 조건 함수
    func missionSuccessCondition() {
        if self.childLeftHand.center.y ==  self.view.bounds.height / 0.5 - self.view.bounds.height * 1.22 {
            self.tapRecognizer.isHidden = false
        }
    }
    
    // 미션 성공시 실행되는 함수
    @objc func tapBell(_ sender: UITapGestureRecognizer) {
        let layer = self.childLeftHand.layer
        self.tappedBusBell.isHidden = false
        generator.impactOccurred()
        avPlayer.play()
        pauseLayer(layer: layer)
        NotificationCenter.default.post(name: .drawBusPoleHint, object: nil)
    }
    
    // 3가지 랜덤한 높이의 반복되는 childeLeftHand Up & Down 애니메이션
    func childHandUpAndDown() {
        UIView.animate(withDuration: 0.8, delay: 0, animations: {
            self.childLeftHand.center.y -= self.view.bounds.height * self.childLeftHandPisitions.randomElement()!
        }, completion: { _ in
            self.missionSuccessCondition()
            UIView.animate(withDuration: 1.5, delay: 0, animations: {
                self.childLeftHand.center.y += self.view.bounds.height * self.childLeftHandPisitions.randomElement()!
            }, completion: { _ in
                self.setupChildHand()
                self.childHandUpAndDown()
            })
        })
    }
}
