//
//  OrderMilkShakeScene.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/26.
//

import SpriteKit
import UIKit
import AudioToolbox

class OrderMilkShakeMissionScene: SKScene, UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    var jumpCount: Int = 0
    var isCheckingMenu: Bool = false
    
    // SKNode들 생성
    let effectNode = SKEffectNode()
    let orderMilkShakeMissionBackground = SKSpriteNode(imageNamed: "orderMilkShakeMissionBackground")
    let menuBoard: SKSpriteNode = SKSpriteNode(imageNamed: "menuBoard")
    let magnifiedMenuBoard: SKSpriteNode = SKSpriteNode(imageNamed: "magnifiedMenuBoard")
    
    var recognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    // Scene이 View에 그려질 때 수행할 작업들을 정의.
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        drawBackground() // 배경 그리기
        drawMenuBoard() // 메뉴판 그리기
        drawMagnifiedMenuBoard() // 확대된 메뉴판 그리기
        
        // Gesture Recognizer 생성
        recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(doubleTapHappened(sender:))
        )
        addDoubleTapGestureRecognizer() // Double-Tap Gesture 추가
    }
    // DoubleTapGesture를 입력받는 변수를 선언하고 SKView에 추가.
    func addDoubleTapGestureRecognizer() {
        recognizer.numberOfTapsRequired = 2
        recognizer.delegate = self
        view?.addGestureRecognizer(recognizer)
    }
    // LongPressGesture 입력 시 수행할 작업 정의
    @objc func doubleTapHappened(sender: UITapGestureRecognizer) {
        
        let jumpHeight = viewHeight * (350 / 1600)
        let jumpUpAction = SKAction.moveBy(x: 0, y: jumpHeight, duration: 0.4)
        let jumpDownAction = SKAction.moveBy(x: 0, y: -jumpHeight, duration: 0.4)
        let jumpSequence = SKAction.sequence([jumpDownAction, jumpUpAction])

        recognizer.isEnabled = false
        orderMilkShakeMissionBackground.run(jumpSequence)
        menuBoard.run(jumpSequence) {
            self.recognizer.isEnabled = true
        }
        
        // 미션 성공 조건 달성
        jumpCount += 1
        menuBoard.alpha += 1/3 // 점프를 할 때마다 메뉴판의 투명도가 감소
        isCheckingMenu = true
        
        if jumpCount == 3 {
            let fadeInSequence = SKAction.sequence(
                [SKAction.wait(forDuration: 0.5),
                 SKAction.fadeIn(withDuration: 1)]
            )
            magnifiedMenuBoard.run(fadeInSequence)
            // MARK: 미션 성공
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                NotificationCenter.default.post(name: .drawCafeDrinkMilkShakeHint, object: nil)
            }
        }
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
    
    // 메뉴판 그리기
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
        menuBoard.alpha = 0.0
        
        self.addChild(menuBoard)
    }
    
    private func drawMagnifiedMenuBoard() {
        magnifiedMenuBoard.size = CGSize(
            width: viewWidth,
            height: viewHeight
        )
        magnifiedMenuBoard.position = CGPoint(
            x: viewWidth / 2,
            y: viewHeight / 2
        )
        magnifiedMenuBoard.zPosition = OrderMilkShakeMissionLayer.magnifiedMenuBoard
        magnifiedMenuBoard.alpha = 0.0
        
        self.addChild(magnifiedMenuBoard)
    }
}

extension SKScene {
    var viewWidth: CGFloat { size.width }
    var viewHeight: CGFloat { size.height }
}
