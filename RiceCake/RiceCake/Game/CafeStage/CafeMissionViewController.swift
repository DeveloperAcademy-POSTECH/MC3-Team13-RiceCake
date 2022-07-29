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
        // CafeNoKidsZone
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeNoKidsZoneHint),
            name: .drawCafeNoKidsZoneHint,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeNoKidsZoneMission),
            name: .drawCafeNoKidsZoneMission,
            object: nil
        )
        // SearchForAnotherCafe
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawSearchForAnotherCafeHint),
            name: .drawSearchForAnotherCafeHint,
            object: nil
        )
        // CafeOrderMilkShake
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeOrderMilkShakeHint),
            name: .drawCafeOrderMilkShakeHint,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeOrderMilkShakeMission),
            name: .drawCafeOrderMilkShakeMission,
            object: nil
        )
        // CafeDrinkMilkShake
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeDrinkMilkShakeHint),
            name: .drawCafeDrinkMilkShakeHint,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawCafeDrinkMilkShakeMission),
            name: .drawCafeDrinkMilkShakeMission,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        drawCafeNoKidsZoneHint()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        eraseCafeMission()
    }
    
    // MARK: 각 힌트, 미션에 해당하는 View/Scene을 그리는 함수들
    // CafeNoKidsZone
    @objc func drawCafeNoKidsZoneHint() {
        eraseCafeMission()
        presentCafeHintScene(missionNumber: 0, nextViewNotificationName: .drawCafeNoKidsZoneMission)
    }
    @objc func drawCafeNoKidsZoneMission() {
        eraseCafeMission()
        drawUIKitViewOnMissionView(storyboardName: "NoKidsZoneMission", storyboardID: "NoKidsZoneMissionViewController")
    }
    // SearchForAnotherCafe
    @objc func drawSearchForAnotherCafeHint() {
        eraseCafeMission()
        presentCafeHintScene(missionNumber: 1, nextViewNotificationName: .searchForNextMission)
    }
    // CafeOrderMilkShake
    @objc func drawCafeOrderMilkShakeHint() {
        eraseCafeMission()
        presentCafeHintScene(missionNumber: 2, nextViewNotificationName: .drawCafeOrderMilkShakeMission)
    }
    @objc func drawCafeOrderMilkShakeMission() {
        eraseCafeMission()
        // SKScene: missionView에 BusSeatMissionScene을 띄웁니다.
        let missionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
        missionView.presentScene(missionScene)
    }
    // CafeDrinkMilkShake
    @objc func drawCafeDrinkMilkShakeHint() {
        eraseCafeMission()
        presentCafeHintScene(missionNumber: 3, nextViewNotificationName: .drawCafeDrinkMilkShakeMission)
    }
    @objc func drawCafeDrinkMilkShakeMission() {
        eraseCafeMission()
        drawUIKitViewOnMissionView(storyboardName: "MilkShakeMission", storyboardID: "MilkShakeMissionViewController")
        
    }
    
    // MARK: View/Scene을 더 편하게 그릴 수 있게 도와주는 함수들
    private func eraseCafeMission() {
        // UIKit: missionView의 모든 subView를 지웁니다.
        for view in self.missionView.subviews {
            view.removeFromSuperview()
        }
    }
    private func presentCafeHintScene(missionNumber: Int, nextViewNotificationName: NSNotification.Name) {
        // UIKit: HintView를 불러옵니다.
        let storyboard = UIStoryboard(name: "HintView", bundle: .main)
        if let child: HintViewController = storyboard.instantiateViewController(identifier: "HintViewController") as? HintViewController {
            child.configure(stageNumber: 1, missionNumber: missionNumber, nextViewNotificationName: nextViewNotificationName)
            child.didMove(toParent: self)
            child.view.frame = missionView.bounds
            addChild(child)
            missionView.addSubview(child.view)
        }
    }
    private func drawUIKitViewOnMissionView(storyboardName: String, storyboardID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let child = storyboard.instantiateViewController(identifier: storyboardID)
        addChild(child)
        missionView.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.frame = missionView.bounds
    }
}
