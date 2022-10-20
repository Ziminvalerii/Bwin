//
//  SettingsModel.swift
//  Bwin
//
//  Created by Tanya Koldunova on 13.10.2022.
//

import UIKit

enum SettingsModel: CaseIterable {
    case sound
    case music
    case vibration
    
    var title: String {
        switch self {
        case .sound:
            return "Sound"
        case .music:
            return "Music"
        case .vibration:
            return "Vibration"
        }
    }
    
    var onImage: UIImage {
        switch self {
        case .sound:
            return UIImage(named: "soundOn")!
        case .music:
            return UIImage(named: "musicOn")!
        case .vibration:
            return UIImage(named: "vibrationOn")!
        }
    }
    
    var offImage: UIImage {
        switch self {
        case .sound:
            return UIImage(named: "soundOff")!
        case .music:
            return UIImage(named: "musicOff")!
        case .vibration:
            return UIImage(named: "vibrationOff")!
        }
    }
    
    var isOn: Bool {
        switch self {
        case .sound:
            return !UserDefaultsValues.soundOff
        case .music:
            return !UserDefaultsValues.musicOff
        case .vibration:
            return !UserDefaultsValues.vibrationOff
        }
    }
    
    func valueChanged() {
        switch self {
        case .sound:
            UserDefaultsValues.soundOff = !UserDefaultsValues.soundOff
            if !UserDefaultsValues.soundOff {
                pressedButtonSound()
            }
        case .music:
            UserDefaultsValues.musicOff = !UserDefaultsValues.musicOff
            if !UserDefaultsValues.musicOff {
                playBackgroundMusic()
            } else {
                stopPlaying()
            }
        case .vibration:
            UserDefaultsValues.vibrationOff = !UserDefaultsValues.vibrationOff
            if !UserDefaultsValues.vibrationOff {
                playVibration()
            }
        }
    }

}
