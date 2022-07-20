//
//  BusSeatMissionConstants.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/18.
//

import SpriteKit

struct BusSeatMissionLayer {
    static let busSeatMissionBackground: CGFloat = 1
    static let playerRightHand: CGFloat = 2
    static let frameWall: CGFloat = 3
}

struct BusSeatPhysicsCategory {
    // 노트 충돌 비트마스크 지정.
    static let CategoryRightHand: UInt32 = 0x1 << 1
    static let CategoryWall: UInt32 = 0x1 << 2
}
