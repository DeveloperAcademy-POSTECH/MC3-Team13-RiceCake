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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: GameScene = GameScene(size: storyView.frame.size)
        storyView.presentScene(scene)
              
        // UIKit: BusPoleMissionViewController 연결
        let storyboard = UIStoryboard(name: "BusPoleMission", bundle: .main)
        if let child = storyboard.instantiateViewController(identifier: "BusPole") as? BusPoleMissionViewController {
            addChild(child)
            missionView.addSubview(child.view)
            child.didMove(toParent: self)
            child.view.frame = missionView.bounds
        }
        
        // SpriteKit: Scene을 MissionView에 연결
        // let missionScene: BusSeatMissionScene = BusSeatMissionScene(size: missionView.frame.size)
        // missionView.presentScene(missionScene)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
