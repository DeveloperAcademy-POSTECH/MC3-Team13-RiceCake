//
//  GameViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/15.
//

import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet var storyView: SKView!
    @IBOutlet var missionView: SKView!
    
    // 프로퍼티 옵저버인 didset을 사용하여 프로퍼티 값이 변경되기 직전에 화면을 갱신합니다.
    var isBusMission: Bool = false {
        didSet {
            if isBusMission {
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
    // MARK: - GameView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        // storyView에 GameScene을 띄웁니다.
        let scene: GameScene = GameScene(size: storyView.frame.size)
        scene.gameSceneDelegate = self
        storyView.presentScene(scene)
                      
        // missionView에 MissionScene을 띄웁니다.
        let missionHintScene: MissionScene = MissionScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// GameSceneDelegate를 채택하여 GameScene에서 protocol에 정의된 method들을 구현합니다.
extension GameViewController: GameSceneDelegate {
    func seatMission(state: Bool) {
        self.isBusMission = state
    }
    
    func poleMission(state: Bool) {
        self.isPoleMission = state
    }
}
