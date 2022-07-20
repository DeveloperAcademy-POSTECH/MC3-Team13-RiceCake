//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit
import UIKit

class BusSeatMissionScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    
    var isTouchingHandle: Bool = false
    
    // 버스시트 배경, 아이의 손 노드 정의.
    let busSeatMissionBackground = SKSpriteNode(imageNamed: "busSeatMissionBackground")
    var childRightHand: SKSpriteNode = SKSpriteNode(imageNamed: "childRightHand")
    var grabbingHand: SKSpriteNode = SKSpriteNode(imageNamed: "grabbingHand")
    let wall: SKSpriteNode = SKSpriteNode(color: .green, size: CGSize(width: 20, height: 20))
    
    // Scene이 View에 그려질 때 수행할 작업들을 정의.
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        // 배경화면 그리기
        drawBackground()
        // 아이의 손을 그리고 드래그 제스쳐를 입력
        drawHand()
        drawGrabbingHand()
        // 가상의 프레임을 부여
        framewall()
        
        // Long-press 제스쳐를 입력받는 변수를 선언하고 SKView에 추가.
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHappened(sender:)))
        recognizer.delegate = self
        recognizer.minimumPressDuration = 1
        view.addGestureRecognizer(recognizer)
    }
    // SKScene에 터치가 시작되었을 때의 작업 정의.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            
        }
    }
    // SKScene 위의 터치 위치가 변했을 때의 작업 정의.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if isTouchingHandle == false {
                // 터치 위치를 따라 아이의 손이 움직이도록 변경
                childRightHand.position = touch.location(in: self)
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var collideBody = SKPhysicsBody()
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            collideBody = contact.bodyB
        } else {
            collideBody = contact.bodyA
        }
        let collideType = collideBody.categoryBitMask
        
        if collideType == BusSeatPhysicsCategory.CategoryWall {
            print("Collision with CategoryWall Occured")
            // 손 사라지게 만들기
            childRightHand.isHidden = true
            //
            isTouchingHandle = true
            grabbingHand.isHidden = false
        }
    }
}
// override 함수 외에 커스텀 함수들을 extension에 정의.
extension BusSeatMissionScene {
    func drawBackground() {
        busSeatMissionBackground.size = CGSize(width: self.size.width + 4, height: self.size.height + 4)
        busSeatMissionBackground.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeatMissionBackground.zPosition = 1
        
        // 흔들림 효과 추가
        let shakeLeft = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 2, y: (self.size.height / 2) - 2), duration: 0.4)
        let shakeRight = SKAction.move(to: CGPoint(x: (self.size.width / 2) + 2, y: (self.size.height / 2) + 2), duration: 0.4)
        let shakeBackground = SKAction.sequence([shakeLeft, shakeRight])
        busSeatMissionBackground.run(SKAction.repeatForever(shakeBackground))
        
        // add to Scene
        self.addChild(busSeatMissionBackground)
    }
    
    // MARK: 손잡이로 대체하기
    func framewall() {
        wall.position = CGPoint(x: self.size.width / 2, y: self.size.height - 20)
        wall.zPosition = BusSeatMissionLayer.frameWall
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        wall.physicsBody?.categoryBitMask = BusSeatPhysicsCategory.CategoryWall
        wall.physicsBody?.affectedByGravity = false
        wall.physicsBody?.isDynamic = false
        
        self.addChild(wall)
    }
    
    func drawHand() {
        let handHeight = self.size.height
        let handWidth = handHeight * (324 / 1600)
        
        childRightHand.size = CGSize(width: handWidth, height: handHeight)
        childRightHand.position = CGPoint(
            x: self.size.width / 2,
            y: 0
        )
        childRightHand.zPosition = BusSeatMissionLayer.playerRightHand
        childRightHand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: handWidth, height: handHeight))
        childRightHand.physicsBody?.categoryBitMask = BusSeatPhysicsCategory.CategoryRightHand
        childRightHand.physicsBody?.contactTestBitMask = BusSeatPhysicsCategory.CategoryWall
        childRightHand.physicsBody?.affectedByGravity = false
        childRightHand.physicsBody?.isDynamic = true
        
        self.addChild(childRightHand)
    }
    
    func drawGrabbingHand() {
        grabbingHand.size = CGSize(
            width: self.size.width,
            height: self.size.height
        )
        grabbingHand.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        grabbingHand.zPosition = BusSeatMissionLayer.playerRightHand
        grabbingHand.isHidden = true
        
        // 흔들림 효과 추가
        let shakeLeft = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 2, y: (self.size.height / 2) - 2), duration: 0.4)
        let shakeRight = SKAction.move(to: CGPoint(x: (self.size.width / 2) + 2, y: (self.size.height / 2) + 2), duration: 0.4)
        let shakeGrabbingHand = SKAction.sequence([shakeLeft, shakeRight])
        grabbingHand.run(SKAction.repeatForever(shakeGrabbingHand))
        
        self.addChild(grabbingHand)
    }
    
    // Long-press 입력 시 수행할 작업 정의
    @objc func longPressHappened(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            childRightHand.zRotation = 1
        }
        if sender.state == .ended {
            childRightHand.zRotation = 0
        }
    }
}
