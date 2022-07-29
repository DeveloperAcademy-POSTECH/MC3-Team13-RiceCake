//
//  InsideSecondCafeScene+Extension.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/27.
//

import SpriteKit

extension InsideCafeScene {
    // MARK: - Game Environment Node들의 속성의 정의합니다.
    func createEnvironment() {
        let cafeInterior = SKSpriteNode(imageNamed: "cafeManager")
        cafeInterior.size = CGSize(width: self.size.width, height: self.size.height)
        cafeInterior.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeInterior.zPosition = InsideCafeLayer.cafeInterior
        cafeInterior.physicsBody = SKPhysicsBody(texture: cafeInterior.texture!, size: self.size)
        cafeInterior.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeInterior.physicsBody?.affectedByGravity = false
        cafeInterior.physicsBody?.isDynamic = false
        
        let cafeChairs = SKSpriteNode(imageNamed: "cafeChairs")
        cafeChairs.size = CGSize(width: self.size.width, height: self.size.height)
        cafeChairs.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeChairs.zPosition = InsideCafeLayer.cafeInterior
        cafeChairs.physicsBody = SKPhysicsBody(texture: cafeChairs.texture!, size: self.size)
        cafeChairs.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeChairs.physicsBody?.affectedByGravity = false
        cafeChairs.physicsBody?.isDynamic = false
        
        let cafeDecoration = SKSpriteNode(imageNamed: "cafeDecoration")
        cafeDecoration.size = CGSize(width: self.size.width, height: self.size.height)
        cafeDecoration.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeDecoration.zPosition = InsideCafeLayer.cafeInterior
        cafeDecoration.physicsBody = SKPhysicsBody(texture: cafeDecoration.texture!, size: self.size)
        cafeDecoration.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeDecoration.physicsBody?.affectedByGravity = false
        cafeDecoration.physicsBody?.isDynamic = false
        
        self.addChild(cafeInterior)
        self.addChild(cafeChairs)
        self.addChild(cafeDecoration)
    }
    
    func createMissionArea() {
        let orderStand = SKSpriteNode(imageNamed: "insideCafeOrder")
        orderStand.size = CGSize(width: self.size.width, height: self.size.height)
        orderStand.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        orderStand.zPosition = InsideCafeLayer.orderStand
        orderStand.physicsBody = SKPhysicsBody(texture: orderStand.texture!, size: self.size)
        orderStand.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.orderStand
        orderStand.physicsBody?.affectedByGravity = false
        orderStand.physicsBody?.isDynamic = false
        
        let seat = SKSpriteNode(imageNamed: "insideCafeChair")
        seat.size = CGSize(width: self.size.width, height: self.size.height)
        seat.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        seat.zPosition = InsideCafeLayer.seat
        seat.physicsBody = SKPhysicsBody(texture: seat.texture!, size: self.size)
        seat.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.seat
        seat.physicsBody?.affectedByGravity = false
        seat.physicsBody?.isDynamic = false
        
        self.addChild(orderStand)
        self.addChild(seat)
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
        player.zPosition = InsideCafeLayer.player
        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.player
        player.physicsBody?.contactTestBitMask = InsideCafePhysicsCategory.cafeInterior | InsideCafePhysicsCategory.orderStand | InsideCafePhysicsCategory.seat
        player.physicsBody?.collisionBitMask = InsideCafePhysicsCategory.cafeInterior | InsideCafePhysicsCategory.orderStand | InsideCafePhysicsCategory.seat
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        
        self.addChild(player)
    }
}
