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
    static let searchForNextMission = Notification.Name("cancelMission")
    
    static let drawBusEnterHint = Notification.Name("drawBusEnterHint")
    
    static let drawBusSeatHint = Notification.Name("drawBusSeatHint")
    static let drawBusSeatMission = Notification.Name("drawBusSeatMission")
    
    static let drawBusStationHint = Notification.Name("drawBusStationHint")
    static let drawBusStationMission = Notification.Name("drawBusStationMission")
    
    static let drawBusBellHint = Notification.Name("drawBusBellHint")
    static let drawBusBellMission = Notification.Name("drawBusBellMission")
    
    static let drawBusPoleHint = Notification.Name("drawBusPoleHint")
    static let drawBusPoleMission = Notification.Name("drawBusPoleMission")
    
    static let drawDrinkHint = Notification.Name("drawDrinkMilkShakeHint")
    static let drawDrinkMission = Notification.Name("drawDrinkMilkShakeMission")
    
    static let eraseBusMission = Notification.Name("eraseBusMission")
    
    // CafeStage
    static let drawCafeNoKidsZoneHint = Notification.Name("drawCafeNoKidsZoneHint")
    static let drawCafeNoKidsZoneMission = Notification.Name("drawCafeNoKidsZoneMission")
    
    static let drawSearchForAnotherCafeHint = Notification.Name("drawSearchForAnotherCafeHint")
    
    static let drawCafeOrderMilkShakeHint = Notification.Name("drawCafeOrderMilkShakeHint")
    static let drawCafeOrderMilkShakeMission = Notification.Name("drawCafeOrderMilkShakeMission")
    
    static let drawCafeDrinkMilkShakeHint = Notification.Name("drawCafeDrinkMilkShakeHint")
    static let drawCafeDrinkMilkShakeMission = Notification.Name("drawCafeDrinkMilkShakeMission")
    
    static let eraseCafeMission = Notification.Name("eraseCafeMission")
}
