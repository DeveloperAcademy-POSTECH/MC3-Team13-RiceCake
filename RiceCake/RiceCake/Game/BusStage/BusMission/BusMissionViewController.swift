//
//  BusMissionViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class BusMissionViewController: UIViewController {
    
    @IBOutlet var missionView: SKView!
    var isBusSeatMissionCleared: Bool = false
    var isBusPoleMissionCleared: Bool = false
    
    // MARK: - BusMissionView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Notification Post를 받았을 때 View/Scene을 전환하기
        notificationBusEnterHint()
        notificationBusSeatMission()
        notificationBusStationMission()
        notificationBusBellMission()
        notificationBusPoleMission()
        checkCompleteMission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        drawBusEnterHint()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        eraseBusMission()
    }
    
    // MARK: View/Scene을 더 편하게 그릴 수 있게 도와주는 함수들
    @objc private func eraseBusMission() {
        // UIKit: missionView의 모든 subView를 지웁니다.
        for view in self.missionView.subviews {
            view.removeFromSuperview()
        }
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    
    private func presentBusHintScene(missionNumber: Int, nextViewNotificationName: NSNotification.Name) {
        // UIKit: HintView를 불러옵니다.
        let storyboard = UIStoryboard(name: "HintView", bundle: .main)
        if let child: HintViewController = storyboard.instantiateViewController(identifier: "HintViewController") as? HintViewController {
            child.configure(stageNumber: 0, missionNumber: missionNumber, nextViewNotificationName: nextViewNotificationName)
            child.didMove(toParent: self)
            child.view.frame = missionView.bounds
            addChild(child)
            missionView.addSubview(child.view)
        }
    }
    
    private func drawUIKitViewOnMissionView(storyboardName: String, storyboardID: String) {
        // UIKit: missionView에 BusPoleMissionView를 연결합니다.
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let child = storyboard.instantiateViewController(identifier: storyboardID)
        addChild(child)
        missionView.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.frame = missionView.bounds
    }
}

// MARK: - Notification 정의
extension BusMissionViewController {
    // BusEnterHint
    func notificationBusEnterHint() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusEnterHint),
            name: .drawBusEnterHint,
            object: nil
        )
    }
    
    @objc func drawBusEnterHint() {
        eraseBusMission()
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        presentBusHintScene(missionNumber: 0, nextViewNotificationName: .searchForNextMission) // 이 힌트 이후에는 아무것도 작동하지 않아야 해서 빈 노티 이름을 넣어둠.
    }
    
    // BusSeatMission
    func notificationBusSeatMission() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusSeatHint),
            name: .drawBusSeatHint,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusSeatMission),
            name: .drawBusSeatMission,
            object: nil
        )
    }
    
    @objc func drawBusSeatHint() {
        eraseBusMission()
        presentBusHintScene(missionNumber: 1, nextViewNotificationName: .drawBusSeatMission)
    }
    @objc func drawBusSeatMission() {
        eraseBusMission()
        // SKScene: missionView에 BusSeatMissionScene을 띄웁니다.
        if !isBusSeatMissionCleared {
            let missionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
            missionView.presentScene(missionScene)
        }
    }
    
    // BusStationMission
    func notificationBusStationMission() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusStationHint),
            name: .drawBusStationHint,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusStationMission),
            name: .drawBusStationMission,
            object: nil
        )
    }
    
    @objc func drawBusStationHint() {
        eraseBusMission()
        presentBusHintScene(missionNumber: 2, nextViewNotificationName: .drawBusStationMission)
    }
    @objc func drawBusStationMission() {
        eraseBusMission()
        drawUIKitViewOnMissionView(storyboardName: "BusStationMission", storyboardID: "BusStationMissionViewController")
    }
    
    // BusBellMission
    func notificationBusBellMission() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusBellHint),
            name: .drawBusBellHint,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusBellMission),
            name: .drawBusBellMission,
            object: nil
        )
    }
    
    @objc func drawBusBellHint() {
        eraseBusMission()
        presentBusHintScene(missionNumber: 3, nextViewNotificationName: .drawBusBellMission)
    }
    @objc func drawBusBellMission() {
        eraseBusMission()
        drawUIKitViewOnMissionView(storyboardName: "BusBellMission", storyboardID: "BusBellMissionViewController")
    }
    
    // BusPoleMission
    func notificationBusPoleMission() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusPoleHint),
            name: .drawBusPoleHint,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(drawBusPoleMission),
            name: .drawBusPoleMission,
            object: nil
        )
    }
    
    @objc func drawBusPoleHint() {
        eraseBusMission()
        presentBusHintScene(missionNumber: 4, nextViewNotificationName: .searchForNextMission)
        isBusSeatMissionCleared = true
    }
    @objc func drawBusPoleMission() {
        if isBusSeatMissionCleared && !isBusPoleMissionCleared {
            eraseBusMission()
            drawUIKitViewOnMissionView(storyboardName: "BusPoleMission", storyboardID: "BusPoleMissionViewController")
        }
    }
    // check Complete Mission
    func checkCompleteMission() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(endBusPoleMission),
            name: .endBusPoleMission,
            object: nil
        )
    }
    
    @objc func endBusPoleMission() {
        isBusPoleMissionCleared = true
        eraseBusMission()
        drawUIKitViewOnMissionView(storyboardName: "BusMissionComplete", storyboardID: "BusMissionCompleteViewController")
    }
}
