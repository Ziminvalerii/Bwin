//
//  InstructionModel.swift
//  Bwin
//
//  Created by Tanya Koldunova on 18.10.2022.
//

import UIKit
import Lottie

enum InstructionModel: CaseIterable {
    case firstTip
    case secondTip
    case thirdTip
    
    var description: String {
        switch self {
        case .firstTip:
            return "The main task is to throw the ball into the basket"
        case .secondTip:
            return "To throw the ball you need to swipe"
        case .thirdTip:
            return "The player who hits the basket the most times wins."
        }
    }
    
    var animationName: String {
        switch self {
        case .firstTip:
            return "courtBacketball"
        case .secondTip:
            return "swipe"
        case .thirdTip:
            return "basketWin"
        }
    }
    
    func createView(frame: CGRect)->LottieAnimationView {
        let view = LottieAnimationView(name: animationName)
        view.frame = frame
        view.loopMode = .loop
        view.animationSpeed = 1
        return view
    }
    
    
}
