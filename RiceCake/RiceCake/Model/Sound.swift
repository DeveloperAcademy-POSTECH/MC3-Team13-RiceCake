//
//  Sound.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/28.
//

import Foundation
import AVFoundation

struct Sound {
    var player: AVAudioPlayer
    let soundName: String
    
    init(player: AVAudioPlayer, soundName: String) {
        self.player = player
        self.soundName = soundName
    }
    
    mutating func playSound() {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        do {
            player = try AVAudioPlayer(contentsOf: url!)
                player.play()
            } catch {
                print("SoundError \(error)")
            }
        }
    
    mutating func stopSound() {
        player.stop()
    }
}
