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
    
    var stage: Stage = Stage(stageName: "Stage Name", imageName: "", storyViewController: UIViewController(), missionViewController: UIViewController())
    
    // MARK: - GameView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStoryView()
        updateMissionView()
    }
    
    func updateStoryView() {
        let viewController = stage.storyViewController
        
        viewController.view.frame = storyView.bounds
        viewController.didMove(toParent: self)
        addChild(viewController)
        storyView.addSubview(viewController.view)
    }
    
    func updateMissionView() {
        let viewController = stage.missionViewController
        
        viewController.view.frame = missionView.bounds
        viewController.didMove(toParent: self)
        addChild(viewController)
        missionView.addSubview(viewController.view)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
