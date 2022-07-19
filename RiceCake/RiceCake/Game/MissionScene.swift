//
//  MissionScene.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/19.
//

import SpriteKit

class MissionScene: SKScene {
    
    override func didMove(to view: SKView) {
        let backGround = SKShapeNode.init(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        backGround.fillColor = .lightGray
        self.addChild(backGround)
    }
}
