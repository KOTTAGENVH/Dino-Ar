//
//  PlaySound.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-16.
//

import AVFoundation

    var audioPlayer: AVAudioPlayer?

func playSound (sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play ()
        }
        catch {
            print("ERROR: Could not find the audio file!")
        }
    }
}

func stopSound() {
    audioPlayer?.stop()
}
