//
//  ShopModel.swift
//  Bwin
//
//  Created by Tanya Koldunova on 18.10.2022.
//

import SpriteKit
import UIKit


enum ShopNodel: String, CaseIterable {
    case ball1 = "com.basicBall.key"
    case ball2 = "com.upgratedBall1.key"
    case ball3 = "com.upgratedBall2.key"
    case ball4 = "com.upgratedBall3.key"
    case ball5 = "com.upgratedBall4.key"
    
    var image: UIImage {
        switch self {
        case .ball1:
            return UIImage(named: "ballTexture")!
        case .ball2:
            return UIImage(named: "ballTexture2")!
        case .ball3:
            return UIImage(named: "ballTexture3")!
        case .ball4:
            return UIImage(named: "ballTexture4")!
        case .ball5:
            return UIImage(named: "ballTexture5")!
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .ball1:
            return SKTexture(imageNamed: "ballTexture")
        case .ball2:
            return SKTexture(imageNamed: "ballTexture2")
        case .ball3:
            return SKTexture(imageNamed: "ballTexture3")
        case .ball4:
            return SKTexture(imageNamed: "ballTexture4")
        case .ball5:
            return SKTexture(imageNamed: "ballTexture5")
        }
    }
    
    var price: Int {
        switch self {
        case .ball1:
            return 0
        case .ball2:
            return 100
        case .ball3:
            return 150
        case .ball4:
            return 200
        case .ball5:
            return 300
        }
    }
}
