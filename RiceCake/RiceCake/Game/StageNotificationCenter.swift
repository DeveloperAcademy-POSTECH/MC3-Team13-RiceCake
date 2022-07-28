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
    
    static let drawBusEnterHint = Notification.Name("drawBusEnterHint")
    
    static let drawBusSeatHint = Notification.Name("drawBusSeatHint")
    static let drawBusSeatMission = Notification.Name("drawBusSeatMission")
    
    static let drawBusStopHint = Notification.Name("drawBusStopHint")
    static let drawBusStopMission = Notification.Name("drawBusStopMission")
    
    static let drawBusBellHint = Notification.Name("drawBusBellHint")
    static let drawBusBellMission = Notification.Name("drawBusBellMission")
    
    static let drawBusPoleHint = Notification.Name("drawBusPoleHint")
    static let drawBusPoleMission = Notification.Name("drawBusPoleMission")
    
    static let drawDrinkHint = Notification.Name("drawDrinkHint")
    static let drawDrinkMission = Notification.Name("drawDrinkMission")
    
    static let eraseBusMission = Notification.Name("eraseBusMission")
    // CafeStage
}
