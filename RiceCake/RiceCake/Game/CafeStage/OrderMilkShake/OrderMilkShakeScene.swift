//
//  OrderMilkShakeScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/26.
//

import SpriteKit
import UIKit

class OrderMilkShakeMissionScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    var isCheckingMenu: Bool = false
    
    // SKNode들 생성
    let orderMilkShakeMissionBackground = SKSpriteNode(imageNamed: "orderMilkShakeMissionBackground")
    let menuBoard: SKSpriteNode = SKSpriteNode(imageNamed: "menuBoard")
//    let magnifiedMenuBoard: SKSpriteNode = SKSpriteNode(imageNamed: "grabbingHand")
    
    // Scene이 View에 그려질 때 수행할 작업들을 정의.
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        drawBackground() // 배경 그리기
        drawMenuBoard() // 메뉴판 그리기
        //        drawMagnifiedMenu() // 손잡이를 잡은 손 그리기
        
        addDoubleTapGestureRecognizer() // Double-Tap Gesture 추가
    }
    // SKScene에 터치가 시작되었을 때의 작업 정의.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            
        }
    }
    // SKScene 위의 터치 위치가 변했을 때의 작업 정의.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    // Double Tap Gesture를 입력받는 변수를 선언하고 SKView에 추가.
    func addDoubleTapGestureRecognizer() {
        //        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHappened(sender:)))
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapHappened(sender:)))
        recognizer.delegate = self
        view?.addGestureRecognizer(recognizer)
    }
    
    // LongPressGesture 입력 시 수행할 작업 정의
    @objc func doubleTapHappened(sender: UITapGestureRecognizer) {
        
        if sender.state == .began {
            // 미션 성공 조건 달성
            isCheckingMenu = true
        }
        if sender.state == .ended {
            
        }
    }
}

// MARK: SKNode들을 그리는 함수들
extension OrderMilkShakeMissionScene {
    // 앞좌석 배경
    private func drawBackground() {
        orderMilkShakeMissionBackground.size = CGSize(
            width: self.size.width,
            height: self.size.height
        )
        orderMilkShakeMissionBackground.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        orderMilkShakeMissionBackground.zPosition = OrderMilkShakeMissionLayer.orderMilkShakeMissionBackground
        
        self.addChild(orderMilkShakeMissionBackground)
    }
    
    // 좌석 손잡이를 잡은 플레이어의 손
    private func drawMenuBoard() {
        menuBoard.size = CGSize(
            width: self.size.width,
            height: self.size.height
        )
        menuBoard.position = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        menuBoard.zPosition = OrderMilkShakeMissionLayer.menuBoard
        
        self.addChild(menuBoard)
    }
}
