//
//  BusMissionViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class BusMissionViewController: UIViewController {
    
    @IBOutlet var missionView: SKView!
    
    // 프로퍼티 옵저버인 didset을 사용하여 프로퍼티 값이 변경되기 직후에 화면을 갱신합니다.
    var isSeatMission: Bool = false {
        didSet {
            if isSeatMission {
                // SpriteKit: missionView의 MissionScene을 BusSeatMissionScene으로 변경합니다.
                let seatMissionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
                missionView.presentScene(seatMissionScene)
            } else {
                // SpriteKit: missionView의 BusSeatMissionScene을 MissionScene으로 변경합니다.
                let missionHintScene: MissionScene = MissionScene(size: missionView.frame.size)
                missionView.presentScene(missionHintScene)
            }
        }
    }
    
    var isPoleMission: Bool = false {
        didSet {
            if isPoleMission {
                // UIKit: missionView에 BusPoleMissionView를 연결합니다.
                let storyboard = UIStoryboard(name: "Cafe", bundle: .main)
                if let child = storyboard.instantiateViewController(identifier: "Cafe") as? MilkShakeMissionViewController {
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
        
        let missionHintScene: MissionScene = MissionScene(size: missionView.frame.size)
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
}
