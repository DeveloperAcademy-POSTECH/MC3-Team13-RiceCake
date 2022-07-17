//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "playerFront")
    var hintString: String = "" {
        didSet {
            descriptionLabel.text = hintString
        }
    }
    var descriptionLabel = SKLabelNode()
    
    // MARK: Sprites Alignment
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        createEnvironment()
        setUpBus()
        createPlayer()
        createTouchArea()
        createDescription()
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
            road.zPosition = Layer.road
            self.addChild(road)
            
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
        busFloor.zPosition =  Layer.busFloor
        
        let busFrame = SKSpriteNode(imageNamed: "busFrame")
        busFrame.size = CGSize(width: self.size.width, height: self.size.height)
        busFrame.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFrame.zPosition =  Layer.busFrame
        busFrame.physicsBody = SKPhysicsBody(texture: busFrame.texture!, size: self.size)
        busFrame.physicsBody?.categoryBitMask = PhysicsCategory.busFrame
        busFrame.physicsBody?.affectedByGravity = false
        busFrame.physicsBody?.isDynamic = false
        
        let busSeat = SKSpriteNode(imageNamed: "busSeat")
        busSeat.size = CGSize(width: self.size.width, height: self.size.height)
        busSeat.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeat.zPosition =  Layer.busSeat
        busSeat.physicsBody = SKPhysicsBody(texture: busSeat.texture!, size: self.size)
        busSeat.physicsBody?.categoryBitMask = PhysicsCategory.busSeat
        busSeat.physicsBody?.affectedByGravity = false
        busSeat.physicsBody?.isDynamic = false
        
        let busPoll = SKSpriteNode(imageNamed: "busPoll")
        busPoll.size = CGSize(width: self.size.width, height: self.size.height)
        busPoll.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busPoll.zPosition =  Layer.busPoll
        busPoll.physicsBody = SKPhysicsBody(texture: busPoll.texture!, size: self.size)
        busPoll.physicsBody?.categoryBitMask = PhysicsCategory.busPoll
        busPoll.physicsBody?.affectedByGravity = false
        busPoll.physicsBody?.isDynamic = false
        
        self.addChild(busFloor)
        self.addChild(busFrame)
        self.addChild(busSeat)
        self.addChild(busPoll)
    }
    
    func createPlayer() {
        let playerWidth = 20
        let playerHeight = 30
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        player.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        player.zPosition = Layer.player
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerWidth, height: playerHeight))
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.busFrame | PhysicsCategory.busPoll | PhysicsCategory.busSeat
        player.physicsBody?.collisionBitMask = PhysicsCategory.busFrame | PhysicsCategory.busPoll | PhysicsCategory.busSeat
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
    }
    
    func createDescription() {
        descriptionLabel = SKLabelNode(fontNamed: "AppleGothic")
        descriptionLabel.fontSize = 18
        descriptionLabel.fontColor = .white
        descriptionLabel.position = CGPoint(x: self.size.width - 10, y: self.size.height - 20)
        descriptionLabel.zPosition = Layer.descriptionLabel
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
            touchArea.zPosition = Layer.touchArea
        }
    }
    
    // MARK: Game Algorithm
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var collideBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            collideBody = contact.bodyB
        } else {
            collideBody = contact.bodyA
        }
        
        let collideType = collideBody.categoryBitMask
        switch collideType {
        case PhysicsCategory.busFrame:
            print("버스 프레임과 부딪혔습니다.")
        case PhysicsCategory.busSeat:
            hintString = "Bus Seat Mission"
            print("Bus Seat Mission 시작!")
        case PhysicsCategory.busPoll:
            hintString = "Bus Poll Mission"
            print("Bus Poll Mission 시작!")
        default:
            break
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
        let movementSpeed = 80.0
        let xPosition = pos.x - player.position.x
        let yPosition = pos.y - player.position.y
        let distance = sqrt(xPosition * xPosition + yPosition * yPosition)
        let radians = atan2(-xPosition, yPosition)
        let degrees = radians * 180 / .pi
        
        switch degrees {
        case -45...45:
            player.texture = SKTexture(imageNamed: "playerBack")
            print("터치영역이 플레이어 기준 위쪽입니다.")
        case 45...135:
            player.texture = SKTexture(imageNamed: "playerLeft")
            print("터치영역이 플레이어 기준 왼쪽입니다.")
        case -135 ... -45:
            player.texture = SKTexture(imageNamed: "playerRight")
            print("터치영역이 플레이어 기준 오른쪽입니다.")
        default:
            player.texture = SKTexture(imageNamed: "playerFront")
            print("터치영역이 플레이어 기준 아래쪽입니다.")
        }
        
        player.run(SKAction.move(to: pos, duration: distance / movementSpeed))
        
        if let node = self.touchArea?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.black
            self.addChild(node)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
