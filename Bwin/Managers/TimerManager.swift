//
//  TimerManager.swift
//  Bwin
//
//  Created by Tanya Koldunova on 17.10.2022.
//

import Foundation
import SpriteKit

protocol TimerDelegate {
    func setUpTime(time: String)
    func timeEnded()
}


class TimerManager {
    weak var scene: SKScene?
    var seconds: Int
    var delegate: TimerDelegate?
    private var startTimerDate: Date?
    
    init(seconds: Int, at scene: SKScene?) {
        self.seconds = seconds
        self.scene = scene
    }
    
    func startTimer() {
      //  if startTimerDate == nil {
            runTimer()
      //  }
    }
    
   private func runTimer() {
        if startTimerDate == nil {
            startTimerDate = Date().addingTimeInterval(TimeInterval(seconds))
        }
        let wait = SKAction.wait(forDuration: 1)
        let block = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.updateTimer()
        }
        let sequance = SKAction.sequence([wait, block])
        scene?.run(SKAction.repeatForever(sequance), withKey: "timer")
    }
    
    private func stopTimer() {
        scene?.removeAction(forKey: "timer")
        startTimerDate = nil
    }
    
    private func updateTimer() {
        guard let startTimerDate = startTimerDate else {return}
        let diff = startTimerDate.timeIntervalSinceNow
        if diff < 0 {
            self.stopTimer()
            self.delegate?.timeEnded()
        } else {
            self.delegate?.setUpTime(time: timeString(time: diff))
        }
        
    }
    
    private func timeString(time: TimeInterval) -> String {
      //  let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i%:%02i", minutes, seconds)
    }
  
}
