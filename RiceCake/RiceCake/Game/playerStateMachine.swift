//
//  playerStateMachine.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/19.
//

import Foundation
import GameplayKit

fileprivate let characterAnimationKey = "Splite Animation"

class PlayerState: GKState {
    unowned var playerNode: SKNode
    
    init(playerNode: SKNode) {
        self.playerNode = playerNode
        super.init()
    }
}

// Landing, Walking, Missioning 3가지 상태 가짐

class LandingState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        switch stateClass {
        case is WalkingState.Type, is MissioningState.Type: return false
        default: return true
        }
    }
    
    let textures = SKTexture(imageNamed: "Player/0")
    lazy var action = { SKAction.animate(with: [textures], timePerFrame: 0.1)}()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

class WalkingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is MissioningState.Type: return false
        default: return true
        }
    }
    let textures:Array<SKTexture> = (0..<6).map({ return "Player/\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.1))}()
    
    override func didEnter(from previousState: GKState?) {
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

class MissioningState: PlayerState {
    var isMissioned: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if isMissioned { return false }
        
        switch stateClass {
        case is LandingState.Type, is WalkingState.Type: return false
        default: return false
        }
    }
    
    let action = SKAction.repeat(.sequence([.fadeAlpha(to: 0.5, duration: 0.01), .wait(forDuration: 0.25), .fadeAlpha(to: 1.0, duration: 0.01), .wait(forDuration: 0.25)]), count:5)
    
    override func didEnter(from previousState: GKState?) {
        isMissioned = true
        
        playerNode.run(action)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.isMissioned = false
            self.stateMachine?.enter(LandingState.self)
        }
    }
}
