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
        
        let cafeLeftChair = SKSpriteNode(imageNamed: "cafeLeftChair")
        cafeLeftChair.size = CGSize(width: self.size.width, height: self.size.height)
        cafeLeftChair.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeLeftChair.zPosition = InsideCafeLayer.cafeInterior
        cafeLeftChair.physicsBody = SKPhysicsBody(texture: cafeLeftChair.texture!, size: self.size)
        cafeLeftChair.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeLeftChair.physicsBody?.affectedByGravity = false
        cafeLeftChair.physicsBody?.isDynamic = false
        
        let cafeRightChair = SKSpriteNode(imageNamed: "cafeRightChair")
        cafeRightChair.size = CGSize(width: self.size.width, height: self.size.height)
        cafeRightChair.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeRightChair.zPosition = InsideCafeLayer.cafeInterior
        cafeRightChair.physicsBody = SKPhysicsBody(texture: cafeRightChair.texture!, size: self.size)
        cafeRightChair.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeRightChair.physicsBody?.affectedByGravity = false
        cafeRightChair.physicsBody?.isDynamic = false
        
        let cafeDecoration = SKSpriteNode(imageNamed: "cafeDecoration")
        cafeDecoration.size = CGSize(width: self.size.width, height: self.size.height)
        cafeDecoration.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeDecoration.zPosition = InsideCafeLayer.cafeInterior
        cafeDecoration.physicsBody = SKPhysicsBody(texture: cafeDecoration.texture!, size: self.size)
        cafeDecoration.physicsBody?.categoryBitMask = InsideCafePhysicsCategory.cafeInterior
        cafeDecoration.physicsBody?.affectedByGravity = false
        cafeDecoration.physicsBody?.isDynamic = false
        
        self.addChild(cafeInterior)
        self.addChild(cafeLeftChair)
        self.addChild(cafeRightChair)
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
