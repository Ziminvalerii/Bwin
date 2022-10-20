//
//  StartPresenter.swift
//  Bwin
//
//  Created by Tanya Koldunova on 19.10.2022.
//

import Foundation

protocol StartViewProtocol: AnyObject {
    func configureBonusView()
    func setBonusTime()
}

protocol StartPresenterProtocol: AnyObject {
    init(view: StartViewProtocol)
    var time: Double {get set}
    func timeString(time: Double) -> String
    func startTimer()
    func stop()
}

class StartPresenter: StartPresenterProtocol {
    weak var view: StartViewProtocol?
    var time: Double = 0.0 {
        didSet {
        if time <= 0 {
            view?.configureBonusView()
            stop()
        } else {
            view?.setBonusTime()
        }
        }
    }
    var timer = Timer()
    required init(view: StartViewProtocol) {
        self.view = view
        time = UserDefaultsValues.bonusDate.timeIntervalSince1970 - Date().timeIntervalSince1970
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.time -= 1.0
        }
    }
    func stop() {
        timer.invalidate()
    }
    
     func timeString(time: Double) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i%:%02i", hours, minutes, seconds)
    }
    
}
