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
                // SpriteKit: Scene을 MissionView에 연결
                let missionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
                missionView.presentScene(missionScene)
            }
        }
    }
    
    var isPoleMission: Bool = false {
        didSet {
            if isPoleMission {
                // UIKit: BusPoleMissionViewController 연결
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: GameScene = GameScene(size: storyView.frame.size)
        scene.gameSceneDelegate = self
        storyView.presentScene(scene)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension GameViewController: GameSceneDelegate {
    func seatMission() {
        self.isBusMission = true
        print(isBusMission)
    }
    
    func missionCancled() {
        self.isBusMission = false
        print(isBusMission)
    }
    
    func poleMission() {
        self.isPoleMission = true
        print(isPoleMission)
    }
}
