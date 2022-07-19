//
//  GameViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/15.
//

import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet var storyView: SKView!
    @IBOutlet var missionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: GameScene = GameScene(size: storyView.frame.size)
        storyView.presentScene(scene)
        
        // https://stackoverflow.com/questions/24038215/how-to-navigate-from-one-view-controller-to-another-using-swift
        //        let busSeatMissionVC = UIStoryboard.init(name: "BusSeatMission", bundle: Bundle.main).instantiateViewController(withIdentifier: "BusSeatMissionVC") as! BusSeatMissionViewController
        //        busSeatMissionVC.view.frame = missionView.bounds
        //        missionView.addSubview(busSeatMissionVC.view)
        //        busSeatMissionVC.didMove(toParent: self)
        
        // MissionView에 BusPoleMissionViewController 연결
        let storyboard = UIStoryboard(name: "BusPoleMission", bundle: .main)
        if let child = storyboard.instantiateViewController(identifier: "BusPole") as? BusPoleMissionViewController {
            addChild(child)
            missionView.addSubview(child.view)
            child.didMove(toParent: self)
            child.view.frame = missionView.bounds
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
