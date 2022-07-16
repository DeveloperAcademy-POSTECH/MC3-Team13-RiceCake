//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit

class GameScene: SKScene {
    
    private var touchAreaNode : SKShapeNode?
    
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
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        let movementSpeed = 200.0
        let x = pos.x - player.position.x
        let y = pos.y - player.position.y
        let distance = sqrt(x * x + y * y)
        
        player.run(SKAction.move(to: pos, duration: distance / movementSpeed))
        
        if let n = self.touchAreaNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.black
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
