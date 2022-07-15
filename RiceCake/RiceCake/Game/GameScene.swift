//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    var player: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 40, height: 60)
        player.position = CGPoint(x: 195, y: 173)
        self.addChild(player)
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.01
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
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
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
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
