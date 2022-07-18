//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit

class BusSeatMissionScene: SKScene, SKPhysicsContactDelegate {
    
    //
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        // 배경화면
        // 아이의 손 (특정 위치에 가면 모양이 바뀌고 고정)
    }
    
    private func drawBackground() {
        
    }
}
