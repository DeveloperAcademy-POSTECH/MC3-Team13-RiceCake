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
        
        NotificationCenter.default.addObserver(self, selector: #selector(drawBusSeatMission), name: .drawBusSeatMission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawBusPoleMission), name: .drawBusPoleMission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(eraseBusMission), name: .eraseBusMission, object: nil)
        
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    
    // MARK: Notification Post를 받았을 때 View/Scene을 전환하기
    // 프로퍼티 옵저버인 willSet을 사용하여 프로퍼티가 변경될 때 화면을 갱신합니다.
    var busStageProgress: BusStageProgress = .busEnterHint {
        willSet {
            switch newValue {
            
            case .busEnterHint:
                presentBusHintScene()
                
            case .seatHint:
                presentBusHintScene()
                
            case .seatMission:
                // SpriteKit: missionView에 BusSeatMissionScene을 띄웁니다.
                let seatMissionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
                missionView.presentScene(seatMissionScene)
                
            case .poleHint:
                presentBusHintScene()
                
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
    // SpriteKit: missionView에 HintScene을 띄웁니다.
    private func presentBusHintScene() {
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    
    // MARK: 가능한 MissionView의 상태를 나타냅니다.
    enum BusStageProgress {
        case busEnterHint,
             seatMission,
             seatHint,
             poleMission,
             poleHint
    }
    
    // MARK: 각 BusStageProgress 때 실행할 함수를
    @objc func drawBusEnterHint() {
        self.busStageProgress = .seatHint
    }
    @objc func drawBusSeatHint() {
        self.busStageProgress = .seatHint
    }
    @objc func drawBusSeatMission() {
        self.busStageProgress = .seatMission
    }
    @objc func drawBusPoleHint() {
        self.busStageProgress = .poleHint
    }
    @objc func drawBusPoleMission() {
        self.busStageProgress = .poleMission
    }
    @objc func eraseBusMission() {
        // UIKit: missionView의 모든 subView를 지웁니다.
        for view in self.missionView.subviews {
            view.removeFromSuperview()
        }
        // SpriteKit: missionView에 HintScene을 띄웁니다.
        let missionHintScene: HintScene = HintScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
}
