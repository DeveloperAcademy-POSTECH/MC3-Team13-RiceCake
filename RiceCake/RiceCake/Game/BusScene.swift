//
//  BusScene.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/19.
//

import Foundation
import SpriteKit
import GameplayKit

class BusScene: SKScene {
    var busplayer: SKNode?
    var road: SKNode?
    var missionseat: SKNode?
    var missionseatNode: SKNode?
    var missionpole: SKNode?
    var missionpoleNode: SKNode?
    var cameraNode: SKCameraNode?
    private var touchArea: SKShapeNode?
    
    // Delegate
    weak var busDelegate: BusSceneDelegate?
    
    // Boolean
    var missionseatBool = false
    var missionpoleBool = false
    
    // Instruct
    let missionLabel = SKLabelNode()
    var mission: String = ""
    
    // Splite Engine
    var previousTimeInterval: TimeInterval = 0
    var playerIsFacingRight = true
    let playerSpeed = 100.0
    
    // Player State
    var playerState: GKStateMachine!
    
    // didMove
    override func didMove(to view: SKView) {
    
        physicsWorld.contactDelegate = self
        
        busplayer = childNode(withName: "busplayer")
        road = childNode(withName: "road")
        missionseat = childNode(withName: "missionseat")
        missionseatNode = missionseat?.childNode(withName: "missionseatNode")
        missionpole = childNode(withName: "missionpole")
        missionpoleNode = missionpole?.childNode(withName: "missionpoleNode")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        missionLabel.position = CGPoint(x: (cameraNode?.position.x)!, y: (cameraNode?.position.y)! + 200)
        missionLabel.fontColor = UIColor.blue
        missionLabel.fontSize = 24
        missionLabel.fontName = "AvenirNext-Bold"
        cameraNode?.addChild(missionLabel)
        
        playerState = GKStateMachine(states: [
        IdleState(playerNode: busplayer!),
        LandingState(playerNode: busplayer!),
        WalkingState(playerNode: busplayer!),
        MissioningState(playerNode: busplayer!)])
        
        createTouchArea()
        
        stateLanding()
        
    }
}

// MARK: Touches
extension BusScene {
// Touch Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        stateWalking()
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
        }
    }
// Touch Down
    func touchDown(atPoint pos: CGPoint) {
        let xPosition = pos.x - busplayer!.position.x
        let yPosition = pos.y - busplayer!.position.y
        let distance = sqrt(xPosition * xPosition + yPosition * yPosition)
        let movePlayer = SKAction.move(to: pos, duration: distance / playerSpeed)
        
        if let node = self.touchArea?.copy() as! SKShapeNode? {
            node.position = pos
            node.strokeColor = SKColor.black
            self.addChild(node)
            busplayer?.run(movePlayer)
    }

    }
    
}
// MARK: Player State Change
extension BusScene {
    func stateIdle() {
        playerState.enter(IdleState.self)
    }
    
    func stateLanding() {
        playerState.enter(LandingState.self)
    }
    
    func stateWalking() {
        playerState.enter(WalkingState.self)
    }
    
    func stateMissioning() {
        playerState.enter(MissioningState.self)
    }
}
// MARK: Action
extension BusScene {
    func loadMissionLabel() {
        if missionseatBool {
            missionLabel.text = "Bus Seat Mission"
        } else if missionpoleBool {
            missionLabel.text = "Bus Pole Mission"
        } else {
            missionLabel.text = "Finding Mission"
        }
    }
}

// MARK: Game Loop
extension BusScene {
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        // Camera
        cameraNode?.position.x = busplayer!.position.x
        cameraNode?.position.y = busplayer!.position.y
        
        // Road 무한반복
        if let road = road {
            road.position = CGPoint(x:0, y:CGFloat(deltaTime) * self.size.height)
            let moveDown = SKAction.moveBy(x: 0, y: -self.size.height / 2, duration: 5)
            let moveReset = SKAction.moveBy(x: 0, y: self.size.height / 2, duration: 0)
            let moveSeqence = SKAction.sequence([moveDown, moveReset])
            road.run(SKAction.repeatForever(moveSeqence))
        }
        
        loadMissionLabel()
        
    }
}

// MARK: Node 생성 Method
extension BusScene {
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

// MARK: Collsion BitMask

extension BusScene: SKPhysicsContactDelegate {
    
    struct Collision {
        
        enum Masks: Int {
            case player, seat, pole
            var bitmask: UInt32 { return 1 << self.rawValue}
        }
        
        let masks: (first: UInt32, second: UInt32)
        
        func matches (_ first: Masks, _ second: Masks) -> Bool {
            return (first.bitmask == masks.first && second.bitmask == masks.second) || (first.bitmask == masks.second && second.bitmask == masks.first)
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = Collision(masks: (first:contact.bodyA.categoryBitMask, second: contact.bodyB.categoryBitMask))
        
        if collision.matches(.player, .seat) {
            missionseatBool = true
            self.busDelegate?.seatMission()
            print("Seat Mission Start")
            loadMissionLabel()
        }
        
        if collision.matches(.player, .pole) {
            missionpoleBool = true
            self.busDelegate?.poleMission()
            print("Pole Mission Start")
            loadMissionLabel()
        }
    }
}
