//
//  BusSeatMissionScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit
import UIKit

class BusSeatMissionScene: SKScene, UIGestureRecognizerDelegate {
    // 버스시트 배경, 아이의 손 노드 정의.
    let busSeatMissionBackground = SKSpriteNode(imageNamed: "busSeatMissionBackground")
    var childRightHand: SKSpriteNode = SKSpriteNode(imageNamed: "childRightHand")
    // Scene이 View에 그려질 때 수행할 작업들을 정의.
    override func didMove(to view: SKView) {
        // 배경화면 그리기
        drawBackground()
        // 아이의 손을 그리고 드래그 제스쳐를 입력
        drawChildRightHand()
        
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
            // 터치 위치를 따라 아이의 손이 움직이도록 변경
            childRightHand.position = touch.location(in: self)
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
// override 함수 외에 커스텀 함수들을 extension에 정의.
extension BusSeatMissionScene {
    //
    func drawBackground() {
        busSeatMissionBackground.size = CGSize(width: self.size.width, height: self.size.height)
        busSeatMissionBackground.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeatMissionBackground.zPosition = BusSeatMissionLayer.busSeatMissionBackground
        self.addChild(busSeatMissionBackground)
    }
    //
    func drawChildRightHand() {
        let handHeight = self.size.width / 2
        let handWidth = handHeight * (324 / 1000)
        
        childRightHand.size = CGSize(width: handWidth, height: handHeight)
        childRightHand.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        childRightHand.zPosition = BusSeatMissionLayer.playerRightHand
        
        childRightHand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: handWidth, height: handHeight))
        childRightHand.physicsBody?.affectedByGravity = false
        self.addChild(childRightHand)
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
