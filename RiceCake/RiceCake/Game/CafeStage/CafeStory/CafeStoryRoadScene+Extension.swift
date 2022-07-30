//
//  CafeStoryScene+Extension.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

extension CafeStoryRoadScene {
    // MARK: - Game Environment Node들의 속성의 정의합니다.
    func createEnvironment() {
        let cafeRoad = SKSpriteNode(imageNamed: "cafeRoad")
        cafeRoad.size = CGSize(width: self.size.width, height: self.size.width * 2)
        cafeRoad.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        cafeRoad.zPosition = CafeStageLayer.cafeRoad
        
        self.addChild(cafeRoad)
    }

    func setUpCafe() {
        let firstCafe = SKSpriteNode(imageNamed: "firstCafe")
        firstCafe.size = CGSize(width: self.size.width, height: self.size.width * 2)
        firstCafe.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        firstCafe.zPosition = CafeStageLayer.firstCafe
        firstCafe.physicsBody = SKPhysicsBody(texture: firstCafe.texture!, size: CGSize(width: self.size.width, height: self.size.width * 2))
        firstCafe.physicsBody?.categoryBitMask = CafeStagePhysicsCategory.cafe
        firstCafe.physicsBody?.affectedByGravity = false
        firstCafe.physicsBody?.isDynamic = false
        
        let secondCafe = SKSpriteNode(imageNamed: "secondCafe")
        secondCafe.size = CGSize(width: self.size.width, height: self.size.width * 2)
        secondCafe.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        secondCafe.zPosition = CafeStageLayer.secondCafe
        secondCafe.physicsBody = SKPhysicsBody(texture: secondCafe.texture!, size: CGSize(width: self.size.width, height: self.size.width * 2))
        secondCafe.physicsBody?.categoryBitMask = CafeStagePhysicsCategory.cafe
        secondCafe.physicsBody?.affectedByGravity = false
        secondCafe.physicsBody?.isDynamic = false
        
        let firstCafeDoor = SKSpriteNode(imageNamed: "firstCafeDoor")
        firstCafeDoor.size = CGSize(width: self.size.width, height: self.size.width * 2)
        firstCafeDoor.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        firstCafeDoor.zPosition = CafeStageLayer.firstCafeDoor
        firstCafeDoor.physicsBody = SKPhysicsBody(texture: firstCafeDoor.texture!, size: CGSize(width: self.size.width, height: self.size.width * 2))
        firstCafeDoor.physicsBody?.categoryBitMask = CafeStagePhysicsCategory.firstCafeDoor
        firstCafeDoor.physicsBody?.affectedByGravity = false
        firstCafeDoor.physicsBody?.isDynamic = false
        
        let secondCafeDoor = SKSpriteNode(imageNamed: "secondCafeDoor")
        secondCafeDoor.size = CGSize(width: self.size.width, height: self.size.width * 2)
        secondCafeDoor.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        secondCafeDoor.zPosition = CafeStageLayer.secondCafeDoor
        secondCafeDoor.physicsBody = SKPhysicsBody(texture: secondCafeDoor.texture!, size: CGSize(width: self.size.width, height: self.size.width * 2))
        secondCafeDoor.physicsBody?.categoryBitMask = CafeStagePhysicsCategory.secondCafeDoor
        secondCafeDoor.physicsBody?.affectedByGravity = false
        secondCafeDoor.physicsBody?.isDynamic = false
        
        self.addChild(firstCafe)
        self.addChild(secondCafe)
        self.addChild(firstCafeDoor)
        self.addChild(secondCafeDoor)
    }
    
    func createTouchArea() {
        self.touchArea = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchArea = self.touchArea {
            touchArea.lineWidth = 1.5
            touchArea.run(SKAction.scale(to: 2, duration: 0.5))
            touchArea.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
            touchArea.zPosition = CafeStageLayer.touchArea
        }
    }
    
    // MARK: - Player Node의 속성을 정의합니다.
    func createPlayer() {
        let playerWidth = 40
        
        player.size = CGSize(width: playerWidth, height: playerWidth - 10)
        player.position = CGPoint(x: self.size.width * 5/7, y: self.size.height / 4)
        player.zPosition = CafeStageLayer.player
        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player.physicsBody?.categoryBitMask = CafeStagePhysicsCategory.player
        player.physicsBody?.contactTestBitMask = CafeStagePhysicsCategory.cafe | CafeStagePhysicsCategory.firstCafeDoor | CafeStagePhysicsCategory.secondCafeDoor
        player.physicsBody?.collisionBitMask = CafeStagePhysicsCategory.cafe | CafeStagePhysicsCategory.firstCafeDoor | CafeStagePhysicsCategory.secondCafeDoor
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
    }
}
