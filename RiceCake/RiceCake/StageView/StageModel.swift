//
//  StageModel.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

struct Stage: Hashable {
    let stageName: String
    let imageName: String
    let storyViewController: UIViewController
    let missionViewController: UIViewController
} 

extension Stage {
    static let list: [Stage] = [
        Stage(stageName: "버스 혼자 탈 수 있어!", imageName: "bus", storyViewController: UIStoryboard(name: "BusStory", bundle: .main).instantiateViewController(identifier: "BusStoryViewController"), missionViewController: UIStoryboard(name: "BusMission", bundle: .main).instantiateViewController(identifier: "BusMissionViewController")),
        Stage(stageName: "달콤한 밀크쉐이크", imageName: "cafe", storyViewController: UIStoryboard(name: "CafeStory", bundle: .main).instantiateViewController(identifier: "CafeStoryViewController"), missionViewController: UIStoryboard(name: "CafeMission", bundle: .main).instantiateViewController(identifier: "CafeMissionViewController"))
    ]
}
