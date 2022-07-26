//
//  BusStoryViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

class BusStoryViewController: UIViewController {
    
    @IBOutlet var storyView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: BusStoryScene = BusStoryScene(size: storyView.frame.size)
        storyView.presentScene(scene)
    }
}
