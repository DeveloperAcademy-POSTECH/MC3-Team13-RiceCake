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
    
    var isBusMission: Bool = false {
        didSet {
            if isBusMission {
                // https://stackoverflow.com/questions/24038215/how-to-navigate-from-one-view-controller-to-another-using-swift
                let busSeatMissionVC = UIStoryboard.init(name: "BusSeatMission", bundle: Bundle.main).instantiateViewController(withIdentifier: "BusSeatMissionVC") as! BusSeatMissionViewController
                busSeatMissionVC.view.frame = missionView.bounds
                missionView.addSubview(busSeatMissionVC.view)
                busSeatMissionVC.didMove(toParent: self)
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
}
