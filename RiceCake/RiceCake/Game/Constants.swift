//
//  Constants.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/17.
//

import SpriteKit

struct Layer {
    static let road: CGFloat = 1
    static let busFloor: CGFloat = 2
    static let busSeat: CGFloat = 3
    static let busPoll: CGFloat = 3
    static let busFrame: CGFloat = 4
    static let player: CGFloat = 5
    static let touchArea: CGFloat = 6
}

struct PhysicsCategory {
    static let player: UInt32 = 0 * 1 << 0  // 1
    static let busFrame: UInt32 = 0 * 1 << 1  // 2
    static let busPoll: UInt32 = 0 * 1 << 2  // 4
    static let busSeat: UInt32 = 0 * 1 << 3  // 8
}
