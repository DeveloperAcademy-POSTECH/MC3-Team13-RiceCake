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
    static let busPole: CGFloat = 3
    static let busFrame: CGFloat = 4
    static let player: CGFloat = 5
    static let touchArea: CGFloat = 6
    static let descriptionLabel: CGFloat = 10
}

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let busFrame: UInt32 = 0x1 << 1
    static let busPole: UInt32 = 0x1 << 2
    static let busSeat: UInt32 = 0x1 << 3
}
