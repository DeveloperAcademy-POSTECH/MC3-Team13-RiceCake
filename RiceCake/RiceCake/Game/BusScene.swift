//
//  BusScene.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/19.
//

import Foundation
import SpriteKit
import GameplayKit

class BusScene: SKScene, SKPhysicsContactDelegate {
    var player: SKNode?
    var road: SKNode?
    var missionseat: SKNode?
    var missionpole: SKNode?
    var cameraNode: SKCameraNode?
    var bus: SKNode?
    
    
    // Boolean
    var missionseatBool = false
    var missionpoleBool = false
    
    // Instruct
    let missionLabel = SKLabelNode()
    var mission: String = ""
    
    // Splite Engine
    var previousTimeInterval: TimeInterval = 0
    var playerIsFacingRight = true
    let playerSpeed = 50.0
    
    // Player State
    var playerState: GKStateMachine!
    
    // didMove
    override func didMove(to view: SKView) {
    
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "player")
        bus = childNode(withName: "bus")
        road = childNode(withName: "road")
        missionseat = childNode(withName: "missionseat")
        missionpole = childNode(withName: "missionpole")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        playerState = GKStateMachine(states: [
        LandingState(playerNode: player!),
        WalkingState(playerNode: player!),
        MissioningState(playerNode: player!)])
//        playerState.enter(LandingState.self)
        
        loadRepeat()
    }

}

// MARK: Touches
extension BusScene {
    // Touch Begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchDown(atPoint: touch.location(in: self))
        }
    }
    // Touch Down
    func touchDown(atPoint pos: CGPoint) {
        
        let busxPosition = pos.x - (bus?.position.x)!
        let busyPosition = pos.y - (bus?.position.y)!
        let busdistance = sqrt(busxPosition * busxPosition + busyPosition * busyPosition)
        let busmovePlayer = SKAction.move(to: pos, duration: busdistance / playerSpeed)
        guard let walkingBySKS = SKAction(named: "walking") else { return }
        bus?.run(walkingBySKS)
        guard let busstopPlayer = SKAction(named: "standing") else { return }
        bus?.run(SKAction.sequence([busmovePlayer, busstopPlayer]))
        
        
        let xPosition = pos.x - (player?.position.x)!
        let yPosition = pos.y - (player?.position.y)!
        let distance = sqrt(xPosition * xPosition + yPosition * yPosition)
        let movePlayer = SKAction.move(to: pos, duration: distance / playerSpeed)
//
//        playerState.enter(WalkingState.self)
//
        guard let walkingBySKS = SKAction(named: "walking") else { return }
        player?.run(walkingBySKS)
        guard let stopPlayer = SKAction(named: "standing") else { return }
        player?.run(SKAction.sequence([movePlayer, stopPlayer]))
        
    }

}

// MARK: Game Loop
extension BusScene {
    func loadRepeat() {
        let roadRepeatNum = Int(ceil(self.size.height / self.size.height))
        
        for index in 0...roadRepeatNum {
            if let road = road {
                road.position = CGPoint(x: 0, y: CGFloat(index) * self.size.height)
                
                let moveDown = SKAction.moveBy(x: 0, y: -self.size.height, duration: 5)
                let moveReset = SKAction.moveBy(x: 0, y: self.size.height, duration: 0)
                let moveSequence = SKAction.sequence([moveDown, moveReset])
                road.run(SKAction.repeatForever(moveSequence))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        // Camera
        cameraNode?.position.x = player!.position.x
        
    }
}
