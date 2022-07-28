//
//  BusMissionViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class BusMissionViewController: UIViewController {
    
    @IBOutlet var missionView: SKView!
    
    // MARK: - BusMissionView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Notification Post를 받았을 때 View/Scene을 전환하기
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusSeatMission),
            name: .drawBusSeatMission,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusPoleMission),
            name: .drawBusPoleMission,
            object: nil
        )
    }
    
    // MARK: 각 힌트, 미션에 해당하는 View/Scene을 그리는 함수들
    @objc func drawBusEnterHint() {
        eraseBusMission()
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        presentBusHintScene()
    }
    @objc func drawBusSeatHint() {
        eraseBusMission()
        presentBusHintScene()
    }
    @objc func drawBusSeatMission() {
        eraseBusMission()
        // SpriteKit: missionView에 BusSeatMissionScene을 띄웁니다.
        let seatMissionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
        missionView.presentScene(seatMissionScene)
    }
    @objc func drawBusPoleHint() {
        eraseBusMission()
        presentBusHintScene()
    }
    @objc func drawBusPoleMission() {
        eraseBusMission()
        // UIKit: missionView에 BusPoleMissionView를 연결합니다.
        let storyboard = UIStoryboard(name: "BusPoleMission", bundle: .main)
        if let child = storyboard.instantiateViewController(identifier: "BusPole") as? BusPoleMissionViewController {
            addChild(child)
            missionView.addSubview(child.view)
            child.didMove(toParent: self)
            child.view.frame = missionView.bounds
        }
    }
    
    // MARK: View/Scene을 더 편하게 그릴 수 있게 도와주는 함수들
    private func eraseBusMission() {
        // UIKit: missionView의 모든 subView를 지웁니다.
        for view in self.missionView.subviews {
            view.removeFromSuperview()
        }
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    private func presentBusHintScene() {
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
}
