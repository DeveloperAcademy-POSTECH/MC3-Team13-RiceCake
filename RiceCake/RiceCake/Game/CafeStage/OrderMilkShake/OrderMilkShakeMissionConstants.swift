//
//  OrderMilkShakeMissionConstants.swift
//  RiceCake
//
//  Created by 임성균 on 2022/07/26.
//

import SpriteKit

struct OrderMilkShakeMissionLayer {
    static let orderMilkShakeMissionBackground: CGFloat = 1
    static let menuBoard: CGFloat = 2
    static let magnifiedMenuBoard: CGFloat = 3
}

struct OrderMilkShakeMissionPhysicsCategory {
    // 노트 충돌 비트마스크 지정.
    static let camera: UInt32 = 0x1 << 1
    static let ground: UInt32 = 0x1 << 2
}
