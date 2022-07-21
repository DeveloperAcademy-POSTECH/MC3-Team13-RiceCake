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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // storyView에 GameScene을 띄웁니다..
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

// storyView에 연결된 GameScene에서 사용할 함수를 설정합니다.
extension GameViewController: GameSceneDelegate {
    func seatMission(state: Bool) {
        self.isBusMission = state
        print(isBusMission)
    }
    
    func poleMission(state: Bool) {
        self.isPoleMission = state
        print(isPoleMission)
    }
}
