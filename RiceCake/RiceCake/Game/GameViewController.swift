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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene: GameScene = GameScene(size: storyView.frame.size)
        storyView.presentScene(scene)
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}