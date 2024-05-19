//
//  PlaySound.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-16.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var soundrecord: String = ""

func playSound(sound: String, type: String) {
    if let soundURL = Bundle.main.url(forResource: sound, withExtension: type) {
        do {
            // Initialize and play the new audio
            soundrecord = sound
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch let error {
            print("ERROR: Could not play the audio file - \(error.localizedDescription)")
        }
    } else {
        print("ERROR: Audio file not found!")
    }
}
func playLaterSound() {
    print("Last Sound:/(soundrecord)")
    if let soundURL = Bundle.main.url(forResource: soundrecord, withExtension: "mp3") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch let error {
            print("ERROR: Could not play the audio file - \(error.localizedDescription)")
        }
    } else {
        print("ERROR: Audio file not found!")
    }
}

func stopSound() {
    audioPlayer?.stop()
}
