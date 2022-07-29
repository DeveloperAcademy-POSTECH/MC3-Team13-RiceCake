//
//  CafeStageConstant.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

// MARK: - CafeRoadScene
struct CafeStageLayer {
    static let cafeRoad: CGFloat = 1
    static let firstCafe: CGFloat = 2
    static let secondCafe: CGFloat = 2
    static let firstCafeDoor: CGFloat = 3
    static let secondCafeDoor: CGFloat = 3
    static let player: CGFloat = 4
    static let touchArea: CGFloat = 5
}

struct CafeStagePhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let cafe: UInt32 = 0x1 << 1
    static let firstCafeDoor: UInt32 = 0x1 << 2
    static let secondCafeDoor: UInt32 = 0x1 << 3
}
// MARK: - InsideCafeScene
struct InsideCafeLayer {
    static let cafeInterior: CGFloat = 1
    static let orderStand: CGFloat = 2
    static let seat: CGFloat = 3
    static let player: CGFloat = 4
    static let touchArea: CGFloat = 5
}

struct InsideCafePhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let cafeInterior: UInt32 = 0x1 << 1
    static let orderStand: UInt32 = 0x1 << 2
    static let seat: UInt32 = 0x1 << 3
}
