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
    
    var isBusMission: Bool = true {
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
        let scene = SKScene(fileNamed: "BusScene")
        scene?.scaleMode = .aspectFill
        scene?.delegate = self
        storyView.presentScene(scene)
            
        storyView.ignoresSiblingOrder = false
        storyView.showsFPS = true
        storyView.showsNodeCount = true
        
        // missionView에 MissionScene을 띄웁니다.
        let missionHintScene: MissionScene = MissionScene(size: missionView.frame.size)
        missionView.presentScene(missionHintScene)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension GameViewController: BusSceneDelegate {
    func seatMission() {
        self.isBusMission = true
    }
    
    func poleMission() {
        self.isPoleMission = true
    }
}

protocol BusSceneDelegate: SKSceneDelegate {
    func seatMission()
    func poleMission()
}
