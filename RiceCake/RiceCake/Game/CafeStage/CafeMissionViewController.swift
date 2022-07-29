//
//  CafeMissionViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class CafeMissionViewController: UIViewController {
    
    @IBOutlet var missionView: SKView!
    
    // MARK: - CafeMissionView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Notification Post를 받았을 때 View/Scene을 전환하기
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeNoKidsZoneMission),
            name: .drawCafeNoKidsZoneMission,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeOrderMilkShakeMission),
            name: .drawCafeOrderMilkShakeMission,
            object: nil
        )
    }
    
    // MARK: 각 힌트, 미션에 해당하는 View/Scene을 그리는 함수들
    @objc func drawCafeEnterHint() {
        eraseCafeMission()
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        presentCafeHintScene()
    }
    @objc func drawCafeNoKidsZoneHint() {
        eraseCafeMission()
        presentCafeHintScene()
    }
    @objc func drawCafeNoKidsZoneMission() {
        eraseCafeMission()
        // SpriteKit: missionView에 CafeOrderMissionScene을 띄웁니다.
        let missionScene = OrderMilkShakeMissionScene(size: missionView.frame.size)
        missionView.presentScene(missionScene)
    }
    @objc func drawCafeOrderMilkShakeHint() {
        eraseCafeMission()
        presentCafeHintScene()
    }
    @objc func drawCafeOrderMilkShakeMission() {
        eraseCafeMission()
        // UIKit: missionView에 CafePoleMissionView를 연결합니다.
//        let storyboard = UIStoryboard(name: "CafePoleMission", bundle: .main)
//        if let child = storyboard.instantiateViewController(identifier: "CafePole") as? CafePoleMissionViewController {
//            addChild(child)
//            missionView.addSubview(child.view)
//            child.didMove(toParent: self)
//            child.view.frame = missionView.bounds
//        }
    }
    
    // MARK: View/Scene을 더 편하게 그릴 수 있게 도와주는 함수들
    private func eraseCafeMission() {
        // UIKit: missionView의 모든 subView를 지웁니다.
        for view in self.missionView.subviews {
            view.removeFromSuperview()
        }
    }
    private func presentCafeHintScene() {
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
}
