//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
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
    
    // didMove에 초기화 시킬 Node들을 정의합니다.
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
        busFloor.zPosition = Layer.busFloor
        
        let busFrame = SKSpriteNode(imageNamed: "busFrame")
        busFrame.size = CGSize(width: self.size.width, height: self.size.height)
        busFrame.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFrame.zPosition = Layer.busFrame
        busFrame.physicsBody = SKPhysicsBody(texture: busFrame.texture!, size: self.size)
        busFrame.physicsBody?.categoryBitMask = PhysicsCategory.busFrame
        busFrame.physicsBody?.affectedByGravity = false
        busFrame.physicsBody?.isDynamic = false
        
        let busSeat = SKSpriteNode(imageNamed: "busSeat")
        busSeat.size = CGSize(width: self.size.width, height: self.size.height)
        busSeat.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeat.zPosition = Layer.busSeat
        busSeat.physicsBody = SKPhysicsBody(texture: busSeat.texture!, size: self.size)
        busSeat.physicsBody?.categoryBitMask = PhysicsCategory.busSeat
        busSeat.physicsBody?.affectedByGravity = false
        busSeat.physicsBody?.isDynamic = false
        
        let busPoll = SKSpriteNode(imageNamed: "busPole")
        busPoll.size = CGSize(width: self.size.width, height: self.size.height)
        busPoll.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busPoll.zPosition = Layer.busPole
        busPoll.physicsBody = SKPhysicsBody(texture: busPoll.texture!, size: self.size)
        busPoll.physicsBody?.categoryBitMask = PhysicsCategory.busPole
        busPoll.physicsBody?.affectedByGravity = false
        busPoll.physicsBody?.isDynamic = false
        
        self.addChild(busFloor)
        self.addChild(busFrame)
        self.addChild(busSeat)
        self.addChild(busPoll)
    }
    
    func createPlayer() {
        let playerWidth = 20
        let playerHeight = 15
        
        player.size = CGSize(width: playerWidth, height: playerHeight)
        player.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        player.zPosition = Layer.player
        player.zRotation = 1.5
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerWidth, height: playerHeight))
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.busFrame | PhysicsCategory.busPole | PhysicsCategory.busSeat
        player.physicsBody?.collisionBitMask = PhysicsCategory.busFrame | PhysicsCategory.busPole | PhysicsCategory.busSeat
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
    
    func setupJoystic() {
        
    }
    
    // MARK: Game Algorithm
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }
    
    // 각 Node들 간의 충돌을 감지합니다.
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
        case PhysicsCategory.busPole:
            hintString = "Bus Pole Mission"
            print("Bus Pole Mission 시작!")
        default:
            break
        }
    }
    
    // 터치가 발생할 때 실행할 코드들을 정의 합니다.
    func touchDown(atPoint pos: CGPoint) {
        
        let movementSpeed = 50.0
        let xPosition = pos.x - player.position.x
        let yPosition = pos.y - player.position.y
        let distance = sqrt(xPosition * xPosition + yPosition * yPosition)
        let radians = atan2(-xPosition, yPosition)
        
        player.isPaused = false
        player.zRotation = radians
        player.run(SKAction.move(to: pos, duration: distance / movementSpeed))
        
        // ActionList파일의 walking action을 가져옵니다.
        guard let walkingBySKS = SKAction(named: "walking") else { return }
        player.run(walkingBySKS)
        
        if let node = self.touchArea?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.black
            self.addChild(node)
        }
    }
}
