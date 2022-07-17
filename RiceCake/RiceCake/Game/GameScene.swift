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
        createEnvironment()
        setUpBus()
        createPlayer()
        createTouchAreaNode()
    }
    
    func createEnvironment() {
        let envAtlas = SKTextureAtlas(named: "Environment")
        let roadTexture = envAtlas.textureNamed("road")
        let roadRepeatNum = Int(ceil(self.size.height / self.size.height))
        
        for index in 0...roadRepeatNum {
            let road = SKSpriteNode(texture: roadTexture)
            road.anchorPoint = CGPoint.zero
            road.size = CGSize(width: self.size.width, height: self.size.height + 1)
            road.position = CGPoint(x: 0, y: CGFloat(index) * self.size.height)
            road.zPosition = 1
            
            addChild(road)
            
            let moveDown = SKAction.moveBy(x: 0, y: -self.size.height, duration: 10)
            let moveReset = SKAction.moveBy(x: 0, y: self.size.height, duration: 0)
            let moveSequence = SKAction.sequence([moveDown, moveReset])
            road.run(SKAction.repeatForever(moveSequence))
        }
    }
    
    func setUpBus() {
        let busFloor = SKSpriteNode(imageNamed: "busFloor")
        busFloor.size = CGSize(width: self.size.width, height: self.size.height)
        busFloor.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFloor.zPosition =  1
        self.addChild(busFloor)
        
        let busFrame = SKSpriteNode(imageNamed: "busFrame")
        busFrame.size = CGSize(width: self.size.width, height: self.size.height)
        busFrame.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFrame.zPosition =  3
        self.addChild(busFrame)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 20, height: 30)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        player.zPosition = 2
        self.addChild(player)
    }
    
    func createTouchAreaNode() {
        self.touchAreaNode = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchAreaNode = self.touchAreaNode {
            touchAreaNode.lineWidth = 1.5
            touchAreaNode.run(SKAction.scale(to: 2, duration: 0.5))
            touchAreaNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
            touchAreaNode.zPosition = 3
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
        let movementSpeed = 100.0
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
