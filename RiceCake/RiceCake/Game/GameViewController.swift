//
//  GameViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/15.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet var storyView: SKView!
    @IBOutlet weak var missionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: GameScene = GameScene(size: storyView.frame.size)
        storyView.presentScene(scene)
        
        // https://stackoverflow.com/questions/24038215/how-to-navigate-from-one-view-controller-to-another-using-swift
        let busSeatMissionVC = UIStoryboard.init(name: "BusSeatMission", bundle: Bundle.main).instantiateViewController(withIdentifier: "BusSeatMissionVC") as! BusSeatMissionViewController
        self.view.addSubview(missionView)
        busSeatMissionVC.view.frame = self.view.bounds
        missionView.addSubview(busSeatMissionVC.view)
        busSeatMissionVC.didMove(toParent: self)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
