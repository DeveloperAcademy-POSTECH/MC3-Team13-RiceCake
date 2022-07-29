//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit
import UIKit

class BusSeatMissionScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    var isGrabbingHandle: Bool = false
    // SKNode들 생성
    let busSeatMissionBackground = SKSpriteNode(imageNamed: "busSeatMissionBackground")
    let childRightHand: SKSpriteNode = SKSpriteNode(imageNamed: "childRightHand")
    let grabbingHand: SKSpriteNode = SKSpriteNode(imageNamed: "grabbingHand")
    let seatHandle: SKSpriteNode = SKSpriteNode(imageNamed: "busSeatHandle")
    
    // Scene이 View에 그려질 때 수행할 작업들을 정의.
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        drawBackground() // 배경화면 그리기
        drawHand() // 움직이는 손 그리기
        drawGrabbingHand() // 손잡이를 잡은 손 그리기
        drawSeatHandle() // 좌석 손잡이 그리기
        
        addLongpressGestureRecognizer() // LongPressGesture 추가
    }
    // SKScene에 터치가 시작되었을 때의 작업 정의.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            
        }
    }
    // SKScene 위의 터치 위치가 변했을 때의 작업 정의.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // 터치 위치를 따라 아이의 손이 움직이도록 변경
            childRightHand.position.x = touch.location(in: self).x
            childRightHand.position.y = touch.location(in: self).y - CGFloat(self.size.height / 4)
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
            // 손 대체하기
            isGrabbingHandle = true
            childRightHand.isHidden = true
            grabbingHand.isHidden = false
        }
    }
    // LongPressGesture를 입력받는 변수를 선언하고 SKView에 추가.
    func addLongpressGestureRecognizer() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHappened(sender:)))
        recognizer.delegate = self
        recognizer.minimumPressDuration = 1
        view?.addGestureRecognizer(recognizer)
    }
    
    // LongPressGesture 입력 시 수행할 작업 정의
    @objc func longPressHappened(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            if (sender.location(in: view).x > ((view?.frame.size.width ?? 0) * (2 / 4)))
                && (sender.location(in: view).x < ((view?.frame.size.width ?? 0) * (3 / 4)))
                && (sender.location(in: view).y > ((view?.frame.size.height ?? 0) * (1 / 5)))
                && (sender.location(in: view).y < ((view?.frame.size.height ?? 0) * (2 / 5)))
                && isGrabbingHandle {
                busSeatMissionBackground.isPaused = true
                grabbingHand.isPaused = true
                // MARK: 미션 성공 조건 달성
            }
        }
        if sender.state == .ended {
            
        }
    }
}

// MARK: SKNode들을 그리는 함수들
extension BusSeatMissionScene {
    // 앞좌석 배경
    func drawBackground() {
        busSeatMissionBackground.size = CGSize(width: self.size.width + 4, height: self.size.height + 4)
        busSeatMissionBackground.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeatMissionBackground.zPosition = BusSeatMissionLayer.busSeatMissionBackground
        
        // 흔들림 효과 추가
        let shakeLeft = SKAction.move(to: CGPoint(x: (self.size.width / 2) - 2, y: (self.size.height / 2) - 2), duration: 0.4)
        let shakeRight = SKAction.move(to: CGPoint(x: (self.size.width / 2) + 2, y: (self.size.height / 2) + 2), duration: 0.4)
        let shakeBackground = SKAction.sequence([shakeLeft, shakeRight])
        busSeatMissionBackground.run(SKAction.repeatForever(shakeBackground))
        
        self.addChild(busSeatMissionBackground)
    }
    
    // 좌석 손잡이
    func drawSeatHandle() {
        seatHandle.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        seatHandle.zPosition = BusSeatMissionLayer.frameWall
        seatHandle.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "busSeatHandle"), size: self.size)
        seatHandle.physicsBody?.categoryBitMask = BusSeatPhysicsCategory.CategoryWall
        seatHandle.physicsBody?.affectedByGravity = false
        seatHandle.physicsBody?.isDynamic = false
        
        self.addChild(seatHandle)
    }
    
    // 플레이어의 손
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
    
    // 좌석 손잡이를 잡은 플레이어의 손
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
}
