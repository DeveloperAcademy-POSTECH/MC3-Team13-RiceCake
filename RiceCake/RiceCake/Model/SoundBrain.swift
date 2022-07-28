//
//  Sound.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/28.
//

import Foundation
import AVFoundation


struct SoundBrain {
    
    var soundNumber = 0
    
    var sounds = [
    Sound(player: AVAudioPlayer(), soundName: "Positive"),
    Sound(player: AVAudioPlayer(), soundName: "Negative"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture0"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture1"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture2"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture3"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture4"),
    Sound(player: AVAudioPlayer(), soundName: "Gesture5"),
    Sound(player: AVAudioPlayer(), soundName: "background")
    ]
    
    mutating func getSound(name:String) {
        var soundNumber = sounds.firstIndex(where: {$0.soundName == name})! ?? 0
        sounds[soundNumber].playSound()
    }
    
    mutating func pauseSound(name:String) {
        var soundNumber = sounds.firstIndex(where: {$0.soundName == name})! ?? 0
        sounds[soundNumber].stopSound()
    }
}
