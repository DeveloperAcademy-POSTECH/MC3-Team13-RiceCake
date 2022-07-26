//
//  CafeStageConstant.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import SpriteKit

struct CafeStageLayer {
    static let player: CGFloat = 5
    static let touchArea: CGFloat = 6
    static let descriptionLabel: CGFloat = 10
}

struct CafeStagePhysicsCategory {
    static let player: UInt32 = 0x1 << 0
}
