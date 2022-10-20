//
//  UserDefaultsValue.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import Foundation
import GameKit

public struct UserDefaultsValues {
    enum Keys {
        static let musicOffKey = "com.musicOff.key"
        static let soundOffKey = "com.soundOff.key"
        static let vibrationOffKey = "com.vibrationOff.key"
        static let brightnessKey = "com.brightness.key"
        static let coinsCountKey = "com.coinsCount.key"
        static let availableBallKey = "com.availableCharacters.key"
        static let currentBallKey = "com.currentCharacters.key"
        static let bonusDateKey = "com.bonusDate.key"
        static let bestScoreKey = "com.bestScore.key"
        static let stakeKey = "com.stake.key"
    }
    
    static var musicOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.musicOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.musicOffKey)
        }
    }
    
    static var soundOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.soundOffKey)
        }
    }
    
    static var vibrationOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.vibrationOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.vibrationOffKey)
        }
    }
    
    static var coinsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.coinsCountKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.coinsCountKey)
        }
    }
    
    static var brightness: Float {
        get {
            return UserDefaults.standard.float(forKey: Keys.brightnessKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.brightnessKey)
        }
    }
    
    static var availableBallsKeys: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.availableBallKey) as? [String] ?? [ShopNodel.ball1.rawValue]
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.availableBallKey)
        }
    }
    
    static var availableBalls: [ShopNodel] {
        get {
            var availableBalls = [ShopNodel]()
            for key in UserDefaultsValues.availableBallsKeys {
                if let ball = ShopNodel(rawValue: key) {
                    availableBalls.append(ball)
                }
            }
            return availableBalls
        } set {
            var ballsKeys = [String]()
            for item in newValue {
                ballsKeys.append(item.rawValue)
            }
            if ballsKeys.count == 0 {
                ballsKeys.append(ShopNodel.ball1.rawValue)
            }
            UserDefaultsValues.availableBallsKeys = ballsKeys
        }
    }
    
    static var currentBallKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.currentBallKey) ?? ShopNodel.ball1.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentBallKey)
        }
    }
    
    static var currentBall: ShopNodel {
        get {
            return ShopNodel(rawValue: UserDefaultsValues.currentBallKey)!
        } set {
            UserDefaultsValues.currentBallKey = newValue.rawValue
        }
    }
    
    static var bonusDate: Date {
        get {
            if let date = UserDefaults.standard.object(forKey: Keys.bonusDateKey) {
                return date as! Date
            } else {
                let date = Date()
                UserDefaultsValues.bonusDate = date
                return date 
            }
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.bonusDateKey)
        }
    }
    
    static var bestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.bestScoreKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.bestScoreKey)
            if GKLocalPlayer.local.isAuthenticated {
                let scoreReporter = GKScore(leaderboardIdentifier: "com.jonokoltd.bwin.Leaderboard")
                scoreReporter.value = Int64(newValue)
                GKScore.report([scoreReporter])
            }
        }
    }
    
    static var stake: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.stakeKey)
        } set {
            return UserDefaults.standard.set(newValue, forKey: Keys.stakeKey)
        }
    }
    
}
