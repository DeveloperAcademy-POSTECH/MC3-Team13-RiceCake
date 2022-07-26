//
//  StageModel.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import Foundation
import UIKit
import SpriteKit

struct Stage: Hashable {
    let stageName: String
    let imageName: String
    let storyViewController: UIViewController
    let missionViewController: UIViewController
}

extension Stage {
    static let list: [Stage] = [
        Stage(stageName: "나 이제 버스도 혼자 탈 수 있다!", imageName: "bus", storyViewController: UIStoryboard(name: "BusPoleMission", bundle: .main).instantiateViewController(identifier: "BusPole"), missionViewController: UIStoryboard(name: "BusPoleMission", bundle: .main).instantiateViewController(identifier: "BusPole")),
    Stage(stageName: "달콤한 밀크쉐이크", imageName: "bus", storyViewController: UIStoryboard(name: "BusPoleMission", bundle: .main).instantiateViewController(identifier: "BusPole"), missionViewController: UIStoryboard(name: "BusPoleMission", bundle: .main).instantiateViewController(identifier: "BusPole"))
    ]
}
