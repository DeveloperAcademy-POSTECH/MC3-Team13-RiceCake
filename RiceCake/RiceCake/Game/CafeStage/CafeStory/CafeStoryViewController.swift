//
//  CafeStoryViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class CafeStoryViewController: UIViewController {

    @IBOutlet var storyView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CafeStoryScene을 present합니다.
        let scene: CafeStoryRoadScene = CafeStoryRoadScene(size: storyView.frame.size)
        storyView.presentScene(scene)
    }
}
