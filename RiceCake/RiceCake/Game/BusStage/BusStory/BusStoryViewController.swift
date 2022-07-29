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
        print("did load")
        
        let scene: BusStoryScene = BusStoryScene(size: storyView.frame.size)
        storyView.presentScene(scene)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        
        print("did disappear")
        let scene: BusStoryScene = BusStoryScene(size: storyView.frame.size)
        storyView.presentScene(scene)
    }
}
