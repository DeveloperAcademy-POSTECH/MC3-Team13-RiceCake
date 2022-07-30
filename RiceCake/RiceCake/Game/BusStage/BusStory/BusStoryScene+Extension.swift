//
//  GameScene+Extension.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/22.
//
// GameScene에 초기화 시킬 Node들을 정의합니다.

import SpriteKit

extension BusStoryScene {
    // MARK: - Game Environment Node들의 속성의 정의합니다.
    func createEnvironment() {
        let envAtlas = SKTextureAtlas(named: "BusEnvironment")
        let roadTexture = envAtlas.textureNamed("road")
        let roadRepeatNum = Int(ceil(self.size.height / self.size.height))
        
        for index in 0...roadRepeatNum {
            let road = SKSpriteNode(texture: roadTexture)
            road.anchorPoint = CGPoint.zero
            road.size = CGSize(width: self.size.width, height: self.size.height + 1)
            road.position = CGPoint(x: 0, y: CGFloat(index) * self.size.height)
            road.zPosition = BusStageLayer.road
            self.addChild(road)
            
            let moveDown = SKAction.moveBy(x: 0, y: -self.size.height, duration: 10)
            let moveReset = SKAction.moveBy(x: 0, y: self.size.height, duration: 0)
            let moveSequence = SKAction.sequence([moveDown, moveReset])
            road.run(SKAction.repeatForever(moveSequence))
        }
    }
    
    func setUpBus() {
        let busFloor = SKSpriteNode(imageNamed: "busFloor")
        busFloor.size = CGSize(width: self.size.width, height: self.size.height)
        busFloor.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFloor.zPosition = BusStageLayer.busFloor
        
        let busFrame = SKSpriteNode(imageNamed: "busFrame")
        busFrame.size = CGSize(width: self.size.width, height: self.size.height)
        busFrame.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busFrame.zPosition = BusStageLayer.busFrame
        busFrame.physicsBody = SKPhysicsBody(texture: busFrame.texture!, size: self.size)
        busFrame.physicsBody?.categoryBitMask = BusStagePhysicsCategory.busFrame
        busFrame.physicsBody?.affectedByGravity = false
        busFrame.physicsBody?.isDynamic = false
        
        busSeat.size = CGSize(width: self.size.width, height: self.size.height)
        busSeat.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busSeat.zPosition = BusStageLayer.busSeat
        busSeat.physicsBody = SKPhysicsBody(texture: busSeat.texture!, size: self.size)
        busSeat.physicsBody?.categoryBitMask = BusStagePhysicsCategory.busSeat
        busSeat.physicsBody?.affectedByGravity = false
        busSeat.physicsBody?.isDynamic = false
        
        let busPole = SKSpriteNode(imageNamed: "busPole")
        busPole.size = CGSize(width: self.size.width, height: self.size.height)
        busPole.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busPole.zPosition = BusStageLayer.busPole
        busPole.physicsBody = SKPhysicsBody(texture: busPole.texture!, size: self.size)
        busPole.physicsBody?.categoryBitMask = BusStagePhysicsCategory.busPole
        busPole.physicsBody?.affectedByGravity = false
        busPole.physicsBody?.isDynamic = false
        
        busMissionPole.size = CGSize(width: self.size.width, height: self.size.height)
        busMissionPole.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        busMissionPole.zPosition = BusStageLayer.busPole
        busMissionPole.physicsBody = SKPhysicsBody(texture: busMissionPole.texture!, size: self.size)
        busMissionPole.physicsBody?.categoryBitMask = BusStagePhysicsCategory.busPole
        busMissionPole.physicsBody?.affectedByGravity = false
        busMissionPole.physicsBody?.isDynamic = false
        
        self.addChild(busFloor)
        self.addChild(busFrame)
        self.addChild(busSeat)
        self.addChild(busPole)
        self.addChild(busMissionPole)
    }
    
    func createDescription() {
        descriptionLabel = SKLabelNode(fontNamed: "AppleGothic")
        descriptionLabel.fontSize = 18
        descriptionLabel.fontColor = .white
        descriptionLabel.position = CGPoint(x: self.size.width - 10, y: self.size.height - 20)
        descriptionLabel.zPosition = BusStageLayer.descriptionLabel
        descriptionLabel.horizontalAlignmentMode = .right
        descriptionLabel.text = hintString
        self.addChild(descriptionLabel)
    }
    
    func createTouchArea() {
        self.touchArea = SKShapeNode.init(circleOfRadius: 4)
        
        if let touchArea = self.touchArea {
            touchArea.lineWidth = 1.5
            touchArea.run(SKAction.scale(to: 2, duration: 0.5))
            touchArea.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
            touchArea.zPosition = BusStageLayer.touchArea
        }
    }
    
    // MARK: - Player Node의 속성을 정의합니다.
    func createPlayer() {
        let playerWidth = 20
        
        player.size = CGSize(width: playerWidth, height: playerWidth - 5)
        player.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        player.zPosition = BusStageLayer.player
        player.zRotation = 1.5
        player.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player.physicsBody?.categoryBitMask = BusStagePhysicsCategory.player
        player.physicsBody?.contactTestBitMask = BusStagePhysicsCategory.busFrame | BusStagePhysicsCategory.busPole | BusStagePhysicsCategory.busMissionPole | BusStagePhysicsCategory.busSeat
        player.physicsBody?.collisionBitMask = BusStagePhysicsCategory.busPole | BusStagePhysicsCategory.busMissionPole | BusStagePhysicsCategory.busFrame
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        self.addChild(player)
        
        // 아이의 행동 반경을 버스 내부로 제한
        let xRange = SKRange(lowerLimit: self.size.width * (1 / 4), upperLimit: self.size.width * (3 / 4))
        let yRange = SKRange(lowerLimit: 0.0, upperLimit: self.size.height * (5 / 6))
        let xConstraint = SKConstraint.positionX(xRange)
        let yConstraint = SKConstraint.positionY(yRange)
        player.constraints = [ xConstraint, yConstraint ]
    }
    
    func createSeatMissionPlayer() {
        let shakeLeft = SKAction.move(to: CGPoint(x: self.size.width * 3/11 - 1, y: self.size.height * 5/11), duration: 0.2)
        let shakeRight = SKAction.move(to: CGPoint(x: self.size.width * 3/11 + 1, y: self.size.height * 5/11), duration: 0.2)
        let shakePlayer = SKAction.sequence([shakeLeft, shakeRight])
        let playerWidth = 20
        
        seatMissionPlayer.size = CGSize(width: playerWidth, height: playerWidth - 5)
        seatMissionPlayer.position = CGPoint(x: self.size.width * 5/7, y: self.size.height * 4/5)
        seatMissionPlayer.zPosition = BusStageLayer.player
        seatMissionPlayer.zRotation = 0
        seatMissionPlayer.run(SKAction.repeatForever(shakePlayer))
        seatMissionPlayer.isHidden = true
        
        self.addChild(seatMissionPlayer)
    }
    
    // MARK: - Notification 함수 정의
    @objc func pauseSeatMissionPlayer() {
        seatMissionPlayer.isPaused = true
    }
    
    @objc func markBusSeat() {
        if !isBusSeatMissionCleared {
            let highlightSeat = SKAction.fadeAlpha(to: 0.5, duration: 0.5)
            let resetSeat = SKAction.fadeAlpha(to: 1, duration: 0.5)
            let sequence = SKAction.sequence([highlightSeat, resetSeat])
            busSeat.run(SKAction.repeatForever(sequence))
        }
    }
    
    @objc func markBusPole() {
        if isBusSeatMissionCleared && !isBusPoleMissionCleared {
            let highlightPole = SKAction.fadeAlpha(to: 0.5, duration: 0.5)
            let resetPole = SKAction.fadeAlpha(to: 1, duration: 0.5)
            let sequence = SKAction.sequence([highlightPole, resetPole])
            busMissionPole.run(SKAction.repeatForever(sequence))
        }
    }
    
    @objc func busSeatMission() {
        self.isBusSeatMission = true
    }
    
    @objc func completeSeatMission() {
        self.isBusSeatMission = false
        self.isBusSeatMissionCleared = true
    }
    
    @objc func busPoleMission() {
        if isBusSeatMissionCleared {
            self.isBusPoleMission = true
        }
    }
    
    @objc func completePoleMission() {
        let completePage = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        completePage.fillColor = .black
        completePage.alpha = 0.0
        completePage.zPosition = BusStageLayer.completePage
        self.addChild(completePage)
        
        self.isBusPoleMissionCleared = true
        completePage.run(SKAction.fadeAlpha(to: 0.8, duration: 2))
        descriptionLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        hintString = "Mission Clear"
    }
}
