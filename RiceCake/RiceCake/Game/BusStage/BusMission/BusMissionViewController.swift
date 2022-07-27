//
//  BusMissionViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class BusMissionViewController: UIViewController {
    
    @IBOutlet var missionView: SKView!
    
    // 프로퍼티 옵저버인 didSet을 사용하여 프로퍼티가 변경된 직후에 화면을 갱신합니다.
    var isSeatMission: Bool = false {
        didSet {
            if isSeatMission {
                // SpriteKit: missionView에 BusSeatMissionScene을 띄웁니다.
                let seatMissionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
                missionView.presentScene(seatMissionScene)
            } else {
                // SpriteKit: missionView에 HintScene을 띄웁니다.
                let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
                missionView.presentScene(missionHintScene)
            }
        }
    }
    
    var isPoleMission: Bool = false {
        didSet {
            if isPoleMission {
                // UIKit: missionView에 BusPoleMissionView를 연결합니다.
                let storyboard = UIStoryboard(name: "BusPoleMission", bundle: .main)
                if let child = storyboard.instantiateViewController(identifier: "BusPole") as? BusPoleMissionViewController {
                    addChild(child)
                    missionView.addSubview(child.view)
                    child.didMove(toParent: self)
                    child.view.frame = missionView.bounds
                }
            } else {
                // UIKit: missionView의 모든 subView를 지웁니다.
                for view in self.missionView.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - BusMissionView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(seat), name: .seatMission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pole), name: .poleMission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancel), name: .cancelMission, object: nil)
        
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    
    @objc func seat() {
        self.isSeatMission = true
    }
    
    @objc func pole() {
        self.isPoleMission = true
    }
    
    @objc func cancel() {
        self.isSeatMission = false
        self.isPoleMission = false
    }
    
    // MARK: enum을 활용한 view/scene 전환 시도
    /// 필요한 Notification Center 정리하기
    /// Notification을 보내면 game 진행도 값을 1 더하는 방식으로는 안 되나?
    /// Notification을 보내야 하는 때는?
    /// 1. 사물과 접촉했을 때 -> 미션 뷰 띄우기
    /// 2. 미션을 끝냈을 때 -> 힌트 뷰 띄우기
    /// 3. Hint를 다 봤을 때 -> 미션 뷰 띄우기
    /// BusStageProgress enum 변수를 하나 추가해서 didSet 하나로 때울 수 없을까?
    ///
    var busStageProgress: BusStageProgress = .initializeView {
        willSet {
            switch newValue {
                
            case .initializeView:
                // UIKit: missionView의 모든 subView를 지웁니다.
                for view in self.missionView.subviews {
                    view.removeFromSuperview()
                }
                
            case .initializeScene:
                // SpriteKit: missionView에 HintScene을 띄웁니다.
                let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
                missionView.presentScene(missionHintScene)
                
            case .seatMission:
                // SpriteKit: missionView에 BusSeatMissionScene을 띄웁니다.
                let seatMissionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
                missionView.presentScene(seatMissionScene)
                
            case .seatHint:
                // SpriteKit: missionView에 HintScene을 띄웁니다.
                let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
                missionView.presentScene(missionHintScene)
                
            case .poleMission:
                // UIKit: missionView에 BusPoleMissionView를 연결합니다.
                let storyboard = UIStoryboard(name: "BusPoleMission", bundle: .main)
                if let child = storyboard.instantiateViewController(identifier: "BusPole") as? BusPoleMissionViewController {
                    addChild(child)
                    missionView.addSubview(child.view)
                    child.didMove(toParent: self)
                    child.view.frame = missionView.bounds
                }
            }
        }
    }
    enum BusStageProgress {
        case initializeView,
             initializeScene,
             
//             enterBusStage,
             seatMission,
             seatHint,
             poleMission
//             poleHint
    }
    @objc func drawSeatMission() {
        self.busStageProgress = .seatMission
    }
    @objc func drawPoleMission() {
        self.busStageProgress = .poleMission
    }
    @objc func eraseView() {
        self.busStageProgress = .initializeView
    }
    @objc func eraseScene() {
        self.busStageProgress = .initializeScene
    }
}
