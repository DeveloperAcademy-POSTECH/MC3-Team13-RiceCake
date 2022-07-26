//
//  OrderMilkShakeScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/26.
//

import SpriteKit
import UIKit

class OrderMilkShakeMissionScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    var jumpCount: Int = 0
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
        //        drawMagnifiedMenuBoard() // 손잡이를 잡은 손 그리기
        
        addDoubleTapGestureRecognizer() // Double-Tap Gesture 추가
    }
    // DoubleTapGesture를 입력받는 변수를 선언하고 SKView에 추가.
    func addDoubleTapGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(doubleTapHappened(sender:))
        )
        recognizer.numberOfTapsRequired = 2
        recognizer.delegate = self
        view?.addGestureRecognizer(recognizer)
    }
    // LongPressGesture 입력 시 수행할 작업 정의
    @objc func doubleTapHappened(sender: UITapGestureRecognizer) {
        
        // 미션 성공 조건 달성
        isCheckingMenu = true
        
        let jumpHeight = viewHeight * (350 / 1600)
        let jumpUpAction = SKAction.moveBy(x: 0, y: jumpHeight, duration: 0.4)
        let jumpDownAction = SKAction.moveBy(x: 0, y: -jumpHeight, duration: 0.4)
        let jumpSequence = SKAction.sequence([jumpDownAction, jumpUpAction])

        orderMilkShakeMissionBackground.run(jumpSequence)
        menuBoard.run(jumpSequence)
    }
}

// MARK: SKNode들을 그리는 함수들
extension OrderMilkShakeMissionScene {
    // 앞좌석 배경
    private func drawBackground() {
        orderMilkShakeMissionBackground.size = CGSize(
            width: viewWidth,
            height: viewHeight * ( 1950 / 1600 )
        )
        orderMilkShakeMissionBackground.position = CGPoint(
            x: viewWidth / 2,
            y: viewHeight / 2 + viewHeight * ( 175 / 1600 )
        )
        orderMilkShakeMissionBackground.zPosition = OrderMilkShakeMissionLayer.orderMilkShakeMissionBackground
        self.addChild(orderMilkShakeMissionBackground)
    }
    
    // 탁상용 메뉴판 그리기
    private func drawMenuBoard() {
        menuBoard.size = CGSize(
            width: viewWidth,
            height: viewHeight * ( 1950 / 1600 )
        )
        menuBoard.position = CGPoint(
            x: viewWidth / 2,
            y: viewHeight / 2 + viewHeight * ( 175 / 1600 )
        )
        menuBoard.zPosition = OrderMilkShakeMissionLayer.menuBoard
        self.addChild(menuBoard)
    }
}

extension SKScene {
    var viewWidth: CGFloat { size.width }
    var viewHeight: CGFloat { size.height }
}
