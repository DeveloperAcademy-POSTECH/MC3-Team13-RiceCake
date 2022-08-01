//
//  CafeStoryRoadScene.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit
import AudioToolbox

class CafeStoryRoadScene: SKScene, SKPhysicsContactDelegate {
    
    let cameraNode = SKCameraNode()
    
    var touchArea: SKShapeNode?
    var player: SKSpriteNode = SKSpriteNode(imageNamed: "player1")
    
    // MARK: - Node 초기화
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        createEnvironment()
        setUpCafe()
        createPlayer()
        createTouchArea()
        
        // 카메라 노드 추가
        camera = cameraNode
        cameraNode.position.x = self.size.width / 2
        cameraNode.position.y = self.size.height / 2
        self.addChild(cameraNode)
    }
    
    // 카메라의 세부 움직임을 설정합니다.
    override func update(_ currentTime: CFTimeInterval) {
        if player.position.y <= self.size.height / 2 {
            camera?.position.y = self.size.height / 2
        } else if player.position.y >= self.size.height * 3/4 {
            camera?.position.y = self.size.height * 3/4
        } else {
            camera?.position.y = player.position.y
        }
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
        case CafeStagePhysicsCategory.cafe:
            print("아얏!")
            
        case CafeStagePhysicsCategory.firstCafeDoor:
            player.isPaused = true
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            NotificationCenter.default.post(name: .drawCafeNoKidsZoneMission, object: nil)
            
        case CafeStagePhysicsCategory.secondCafeDoor:
            let scene = InsideCafeScene(size: self.size)
            self.view?.presentScene(scene)
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            NotificationCenter.default.post(name: .drawCafeOrderMilkShakeHint, object: nil)
            
        default:
            break
        }
    }
    
    // 터치가 발생할 때 실행할 코드들을 정의 합니다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
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
        
        player.isPaused = false
        player.zRotation = radians
        player.run(walkingBySKS)
        player.run(SKAction.sequence([movePlayer, stopPlayer]))
    }
}
