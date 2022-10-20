//
//  AudioManager.swift
//  Bwin
//
//  Created by Tanya Koldunova on 18.10.2022.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?
var pressedPlayer: AVAudioPlayer?
var congratulationPlayer: AVAudioPlayer?
var fallPlayer: AVAudioPlayer?

func playBackgroundMusic() {
    if !UserDefaultsValues.musicOff {
    guard let url = Bundle.main.url(forResource: "backgroung",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = player else { return }
        player.volume = 0.1
        player.numberOfLoops = -1
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func pressedButtonSound() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "pressSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        pressedPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let pressedPlayer = pressedPlayer else { return }
        pressedPlayer.volume = 1.0
        pressedPlayer.numberOfLoops = 0
        pressedPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func congratulationSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "congratulation",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        congratulationPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let congratulationPlayer = congratulationPlayer else { return }
        congratulationPlayer.volume = 1.0
        congratulationPlayer.numberOfLoops = 0
        stopPlaying()
        congratulationPlayer.play()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            playBackgroundMusic()
        })
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func fallSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "fallSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        fallPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let fallPlayer = fallPlayer else { return }
        fallPlayer.volume = 1.0
        fallPlayer.numberOfLoops = 0
        fallPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func stopPlaying() {
    player?.stop()
}
