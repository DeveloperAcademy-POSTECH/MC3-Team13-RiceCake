//
//  CafeStoryScene+Extension.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

extension CafeStoryRoadScene {
    // MARK: - Game Environment Node들의 속성의 정의합니다.
    func createDescription() {
        descriptionLabel = SKLabelNode(fontNamed: "AppleGothic")
        descriptionLabel.fontSize = 18
        descriptionLabel.fontColor = .white
        descriptionLabel.position = CGPoint(x: self.size.width - 10, y: self.size.height - 20)
        descriptionLabel.zPosition = BusStageLayer.descriptionLabel
        descriptionLabel.horizontalAlignmentMode = .right
        descriptionLabel.text = hintString
        self.addChild(descriptionLabel)
    }
    
    func createTouchArea() {
        self.touchArea = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchArea = self.touchArea {
            touchArea.lineWidth = 1.5
            touchArea.run(SKAction.scale(to: 2, duration: 0.5))
            touchArea.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
            touchArea.zPosition = BusStageLayer.touchArea
        }
    }
    
    // MARK: - Player Node의 속성을 정의합니다.
    func createPlayer() {
        let playerWidth = 20
        
        player.size = CGSize(width: playerWidth, height: playerWidth - 5)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        player.zPosition = BusStageLayer.player
        player.zRotation = 1.5
//        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
//        player.physicsBody?.categoryBitMask =
//        player.physicsBody?.contactTestBitMask =
//        player.physicsBody?.collisionBitMask =
//        player.physicsBody?.affectedByGravity = false
//        player.physicsBody?.isDynamic = true
        self.addChild(player)
    }
}
