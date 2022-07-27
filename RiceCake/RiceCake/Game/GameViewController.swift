//
//  GameViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/15.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var storyView: UIView!
    @IBOutlet var missionView: UIView!
    
    var stage: Stage = Stage(stageName: "Stage Name", imageName: "", storyViewController: UIViewController(), missionViewController: UIViewController())
    
    // MARK: - GameView를 초기화 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStoryView()
        updateMissionView()
    }
    // StageModel에서 각 Stage별 ViewController를 받아와 storyView를 그려줍니다.
    func updateStoryView() {
        let viewController = stage.storyViewController
        
        viewController.view.frame = storyView.bounds
        viewController.didMove(toParent: self)
        addChild(viewController)
        storyView.addSubview(viewController.view)
    }
    // StageModel에서 각 Stage별 ViewController를 받아와 missionView를 그려줍니다.
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
