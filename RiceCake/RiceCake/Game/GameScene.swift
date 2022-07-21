//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit
import AudioToolbox

// GameViewController에서 정의된 함수를 가져옵니다.
protocol GameSceneDelegate: AnyObject {
    func seatMission(state: Bool)
    func poleMission(state: Bool)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameSceneDelegate: GameSceneDelegate?
    var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    var seatMissionPlayer: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    var descriptionLabel = SKLabelNode()
    var hintString: String = "" {
        didSet {
            descriptionLabel.text = hintString
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        createEnvironment()
        setUpBus()
        createPlayer()
        createSeatMissionPlayer()
        createTouchArea()
        createDescription()
    }
    
    // MARK: Game 알고리즘을 정의합니다.
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
        // Node간의 접촉을 감지하여 실행할 코드들을 정의 합니다.
        switch collideType {
        case PhysicsCategory.busFrame:
            print("버스 프레임과 부딪혔습니다.")
            
        case PhysicsCategory.busSeat:
            gameSceneDelegate?.seatMission(state: true)
            player.isHidden = true
            seatMissionPlayer.isHidden = false
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            hintString = "Bus Seat Mission"
            
        case PhysicsCategory.busPole:
            gameSceneDelegate?.poleMission(state: true)
            player.isPaused = true
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            hintString = "Bus Pole Mission"
            
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
        let movePlayer = SKAction.move(to: pos, duration: distance / movementSpeed)
        let radians = atan2(-xPosition, yPosition)
        // ActionList파일의 walking과 standing action을 가져옵니다.
        guard let walkingBySKS = SKAction(named: "walking") else { return }
        guard let stopPlayer = SKAction(named: "standing") else { return }
        
        if let node = self.touchArea?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.black
            self.addChild(node)
        }
        
        gameSceneDelegate?.seatMission(state: false)
        gameSceneDelegate?.poleMission(state: false)
        hintString = ""
        player.isPaused = false
        player.isHidden = false
        seatMissionPlayer.isHidden = true
        player.zRotation = radians
        player.run(walkingBySKS)
        player.run(SKAction.sequence([movePlayer, stopPlayer]))
    }
}

// MARK: didMove에 초기화 시킬 Node들을 정의합니다.
extension GameScene {
    
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
        
        player.size = CGSize(width: playerWidth, height: playerWidth - 5)
        player.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        player.zPosition = Layer.player
        player.zRotation = 1.5
        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.busFrame | PhysicsCategory.busPole | PhysicsCategory.busSeat
        player.physicsBody?.collisionBitMask = PhysicsCategory.busPole | PhysicsCategory.busFrame
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
        
        // 아이의 행동 반경을 버스 내부로 제한
        let xRange = SKRange(lowerLimit: self.size.width * (1 / 4), upperLimit: self.size.width * (3 / 4))
        let yRange = SKRange(lowerLimit: 0.0, upperLimit: self.size.height * (5 / 6))
        let xConstraint = SKConstraint.positionX(xRange)
        let yConstraint = SKConstraint.positionY(yRange)
        player.constraints = [ xConstraint, yConstraint ]
    }
    
    func createSeatMissionPlayer() {
        let shakeLeft = SKAction.move(to: CGPoint(x: self.size.width * 3/11 - 1, y: self.size.height * 5/11), duration: 0.2)
        let shakeRight = SKAction.move(to: CGPoint(x: self.size.width * 3/11 + 1, y: self.size.height * 5/11), duration: 0.2)
        let shakePlayer = SKAction.sequence([shakeLeft, shakeRight])
        let playerWidth = 20
        
        seatMissionPlayer.size = CGSize(width: playerWidth, height: playerWidth - 5)
        seatMissionPlayer.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        seatMissionPlayer.zPosition = Layer.player
        seatMissionPlayer.zRotation = 0
        seatMissionPlayer.run(SKAction.repeatForever(shakePlayer))
        seatMissionPlayer.isHidden = true
        
        self.addChild(seatMissionPlayer)
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
}
