//
//  AudioPlayer.swift
//  Restart
//
//  Created by Vijay Singh on 29/02/24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            audioPlayer?.play()
        }catch{
            print("could not play the sound file")
        }
    }
}
