//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit

class BusSeatMissionScene: SKScene {
    
    //
    override func didMove(to view: SKView) {
//        self.physicsWorld.contactDelegate = self
        
        // 배경화면
         drawBackground()
        
        // 아이의 손 (특정 위치에 가면 모양이 바뀌고 고정)
        // createPlayerRightHand
    }
    
    func drawBackground() {
        let busSeatMissionBackground = SKSpriteNode(imageNamed: "busSeatMissionBackground")
        busSeatMissionBackground.size = CGSize(width: self.size.width,
                                               height: self.size.height)
        busSeatMissionBackground.position = CGPoint(x: self.size.width / 2,
                                                    y: self.size.height / 2)
        busSeatMissionBackground.zPosition = BusSeatMissionLayer.busSeatMissionBackground
        
        self.addChild(busSeatMissionBackground)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
