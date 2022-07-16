//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit

class GameScene: SKScene {
    
    private var touchAreaNode: SKShapeNode?
    
    var player: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 20, height: 30)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(player)
        
        // Create shape node to use during mouse interaction
        self.touchAreaNode = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchAreaNode = self.touchAreaNode {
            touchAreaNode.lineWidth = 1.5
            touchAreaNode.run(SKAction.scale(to: 2, duration: 0.5))
            touchAreaNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
        let movementSpeed = 200.0
        let xPosition = pos.x - player.position.x
        let yPosition = pos.y - player.position.y
        let distance = sqrt(xPosition * xPosition + yPosition * yPosition)
        
        player.run(SKAction.move(to: pos, duration: distance / movementSpeed))
        
        if let node = self.touchAreaNode?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.black
            self.addChild(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
