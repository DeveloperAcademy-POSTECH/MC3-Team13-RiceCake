//
//  HintModel.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/27.
//

import Foundation

struct StageHint: Codable {
    let stageId: Int
    let missionHints: [MissionHint]
}

struct MissionHint: Codable, Identifiable {
    let id: Int
    let content: [SpeachBubbles]
}

struct SpeachBubbles: Codable, Identifiable {
    let id: Int
    let text: String
    var isLeft: Bool? = false
}

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
