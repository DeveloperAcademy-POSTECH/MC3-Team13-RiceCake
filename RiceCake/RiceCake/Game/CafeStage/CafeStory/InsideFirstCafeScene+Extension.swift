//
//  InsideCafeScene+Extension.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/27.
//

import SpriteKit

extension InsideFirstCafeScene {
    // MARK: - Game Environment Node들의 속성의 정의합니다.
    func createDoor() {
        let exitDoor = SKShapeNode.init(circleOfRadius: 10)
        exitDoor.position = CGPoint(x: self.size.width / 2, y: 0)
        exitDoor.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        exitDoor.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.exitDoor
        exitDoor.physicsBody?.affectedByGravity = false
        exitDoor.physicsBody?.isDynamic = false
        
        self.addChild(exitDoor)
    }
    
    func createTouchArea() {
        self.touchArea = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchArea = self.touchArea {
            touchArea.lineWidth = 1.5
            touchArea.run(SKAction.scale(to: 2, duration: 0.5))
            touchArea.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
            touchArea.zPosition = InsideCafeLayer.touchArea
        }
    }
    // MARK: - Player Node의 속성을 정의합니다.
    // TODO: Player의 Constaints를 설정해야합니다.
    func createPlayer() {
        let playerWidth = 40
        
        player.size = CGSize(width: playerWidth, height: playerWidth - 10)
        player.position = CGPoint(x: self.size.width / 2, y: 30)
        player.zPosition = CafeStageLayer.player
        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.player
        player.physicsBody?.contactTestBitMask = InsideCafePhysicsCategory.exitDoor
        player.physicsBody?.collisionBitMask = InsideCafePhysicsCategory.exitDoor
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
    }
}
