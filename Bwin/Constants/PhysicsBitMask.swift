//
//  PhysicsBitMask.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit

enum PhysicsBitMask {
    case ball
    case ground
    case hoop
    case secondGround
    case goal
    
    var bitMask: UInt32 {
        switch self {
        case .ball:
            return 0x1 << 1
        case .ground:
            return 0x1 << 2
        case .hoop:
            return 0x1 << 3
        case .secondGround:
            return 0x1 << 4
        case .goal:
            return 0x1 << 5
        }
    }
}
