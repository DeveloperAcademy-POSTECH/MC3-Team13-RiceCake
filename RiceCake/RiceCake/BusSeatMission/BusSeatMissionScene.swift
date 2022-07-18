//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit

class BusSeatMissionScene: SKScene {
    
    var childRightHand: SKSpriteNode = SKSpriteNode(imageNamed: "childRightHand")
    
    //
    override func didMove(to view: SKView) {
//        self.physicsWorld.contactDelegate = self
        
        // 배경화면
         drawBackground()
        
        // 아이의 손 (특정 위치에 가면 모양이 바뀌고 고정)
         drawChildRightHand()
        
    }
    
    func drawBackground() {
        let busSeatMissionBackground = SKSpriteNode(imageNamed: "busSeatMissionBackground")
        busSeatMissionBackground.size = CGSize(width: self.size.width, height: self.size.height)
        busSeatMissionBackground.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeatMissionBackground.zPosition = BusSeatMissionLayer.busSeatMissionBackground
        
        self.addChild(busSeatMissionBackground)
    }
    
    func drawChildRightHand() {
        let handHeight = self.size
            .width / 2
        let handWidth = handHeight * (324 / 1000)
        
        childRightHand.size = CGSize(width: handWidth, height: handHeight)
        childRightHand.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        childRightHand.zPosition = BusSeatMissionLayer.playerRightHand
        
        childRightHand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: handWidth, height: handHeight))
        childRightHand.physicsBody?.affectedByGravity = false
//        childRightHand.physicsBody?.is
        
        self.addChild(childRightHand)
    }
    
    func dragGesture(atPoint position: CGPoint) {
//        let movementSpeed = 200.0
//        let xPosition = position.x - childRightHand.position.x
//        let yPosition = position.y - childRightHand.position.y
        
        childRightHand.run(SKAction.move(to: position, duration: 0.5))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.dragGesture(atPoint: touch.location(in: self))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
