//
//  busStageNotificationCenter.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/26.
//

import Foundation

// NotificationCenter에 추가
extension Notification.Name {
    // MARK: - BusStage
    // Bus Stage Mission
    static let searchForNextMission = Notification.Name("cancelMission")
    // Bus Stage 시작
    static let drawBusEnterHint = Notification.Name("drawBusEnterHint")
    // Bus Seat Mission
    static let drawBusSeatHint = Notification.Name("drawBusSeatHint")
    static let drawBusSeatMission = Notification.Name("drawBusSeatMission")
    // Bus Station Mission
    static let drawBusStationHint = Notification.Name("drawBusStationHint")
    static let drawBusStationMission = Notification.Name("drawBusStationMission")
    // Bus Bell Mission
    static let drawBusBellHint = Notification.Name("drawBusBellHint")
    static let drawBusBellMission = Notification.Name("drawBusBellMission")
    // Bus Pole Mission
    static let drawBusPoleHint = Notification.Name("drawBusPoleHint")
    static let drawBusPoleMission = Notification.Name("drawBusPoleMission")
    // Erase Mission
    static let eraseBusMission = Notification.Name("eraseBusMission")
    
    // MARK: - CafeStage
    // Cafe Stage Mission
    static let drawSearchForAnotherCafeHint = Notification.Name("drawSearchForAnotherCafeHint")
    // Cafe NokidsZone Mission
    static let drawCafeNoKidsZoneHint = Notification.Name("drawCafeNoKidsZoneHint")
    static let drawCafeNoKidsZoneMission = Notification.Name("drawCafeNoKidsZoneMission")
    // Cafe Order Mission
    static let drawCafeOrderMilkShakeHint = Notification.Name("drawCafeOrderMilkShakeHint")
    static let drawCafeOrderMilkShakeMission = Notification.Name("drawCafeOrderMilkShakeMission")
    // Cafe Drink Mission
    static let drawCafeDrinkMilkShakeHint = Notification.Name("drawCafeDrinkMilkShakeHint")
    static let drawCafeDrinkMilkShakeMission = Notification.Name("drawCafeDrinkMilkShakeMission")
    // Erase Mission
    static let eraseCafeMission = Notification.Name("eraseCafeMission")
}
