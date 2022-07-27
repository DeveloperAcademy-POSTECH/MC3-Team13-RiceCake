//
//  InsideSecondCafeScene.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/27.
//

import SpriteKit

class InsideSecondCafeScene: SKScene, SKPhysicsContactDelegate {
    
    var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    
    // MARK: - Node 초기화
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        createDoor()
        createPlayer()
        createTouchArea()
    }
    
    // 터치가 발생할 때 실행할 코드들을 정의 합니다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
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
        case InsideCafePhysicsCategory.exitDoor:
            let scene = CafeStoryRoadScene(size: self.size)
            self.view?.presentScene(scene)
            scene.player.position.x = self.size.width * 3/10
            scene.player.position.y = self.size.height * 3/4
            scene.player.zRotation = 3.15
            print("출입문과 부딪혔습니다.")
            
        default:
            break
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
        let movementSpeed = 100.0
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
        
        player.zRotation = radians
        player.run(walkingBySKS)
        player.run(SKAction.sequence([movePlayer, stopPlayer]))
    }
}
