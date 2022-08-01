//
//  GameScene.swift
//  gameTest
//
//  Created by Jung Yunseong on 2022/07/14.
//

import SpriteKit
import AudioToolbox

class BusStoryScene: SKScene, SKPhysicsContactDelegate {
    
    let seatMissionPlayer: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    let busSeat = SKSpriteNode(imageNamed: "busSeat")
    let busMissionPole = SKSpriteNode(imageNamed: "busMissionPole")
    
    var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    var isBusSeatMissionCleared: Bool = false
    var isBusSeatMission: Bool = false
    var isBusPoleMissionCleared: Bool = false
    var isBusPoleMission: Bool = false
    var endingLabel = SKLabelNode()
    
    // MARK: - Node 초기화
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        notificationSetting()
        
        self.isBusSeatMission = false
        self.isBusPoleMission = false
        self.isBusSeatMissionCleared = false
        self.isBusPoleMissionCleared = false
        
        createEnvironment()
        setUpBus()
        createPlayer()
        createSeatMissionPlayer()
        createTouchArea()
        createDescription()
    }
    
    // MARK: Game 알고리즘을 정의합니다.
    // 각 Node들간의 충돌을 감지합니다.
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
        case BusStagePhysicsCategory.busSeat:
            if !isBusSeatMissionCleared {
                player.isHidden = true
                busSeat.run(SKAction.repeatForever(SKAction.fadeAlpha(to: 1, duration: 1)))
                NotificationCenter.default.post(name: .drawBusSeatHint, object: nil)
                seatMissionPlayer.isHidden = false
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        case BusStagePhysicsCategory.busPole:
            if !isBusPoleMissionCleared {
                player.isPaused = true
                busMissionPole.run(SKAction.repeatForever(SKAction.fadeAlpha(to: 1, duration: 1)))
                NotificationCenter.default.post(name: .drawBusPoleMission, object: nil)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        default:
            break
        }
    }
    
    // 터치가 발생할 때 실행할 코드들을 정의 합니다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isBusPoleMissionCleared && !isBusSeatMission && !isBusPoleMission {
            for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
        }
    }
    
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
        
        player.isPaused = false
        NotificationCenter.default.post(name: .eraseBusMission, object: nil)
        seatMissionPlayer.isHidden = true
        player.isHidden = false
        player.zRotation = radians
        player.run(walkingBySKS)
        player.run(SKAction.sequence([movePlayer, stopPlayer]))
    }
}
