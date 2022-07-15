//
//  StageModel.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import Foundation
import UIKit

struct Stage: Hashable {
    let stageName: String
    let imageName: String
}

extension Stage {
    static let list: [Stage] = [
        Stage(stageName: "First Stage", imageName: "bus"),
        Stage(stageName: "Second Stage", imageName: "bus"),
        Stage(stageName: "Third Stage", imageName: "bus"),
        Stage(stageName: "Fourth Stage", imageName: "bus")
    ]
}
