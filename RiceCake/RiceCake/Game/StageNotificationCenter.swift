//
//  busStageNotificationCenter.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import Foundation

// NotificationCenter에 추가
extension Notification.Name {
    // BusStage
    static let seatMission = Notification.Name("seatMission")
    static let poleMission = Notification.Name("poleMission")
    static let cancelMission = Notification.Name("cancelMission")
    
    // CafeStage
}
