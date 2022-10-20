//
//  GameOverOverlay.swift
//  Bwin
//
//  Created by Tanya Koldunova on 17.10.2022.
//

import Foundation
import SpriteKit

enum GameOverType {
    case win
    case loose
    case draw
    case waiting
    
    var texture: SKTexture {
        switch self {
        case .win:
            return SKTexture(imageNamed: "winImage")
        case .loose:
            return SKTexture(imageNamed: "looseImage")
        case .draw:
            return SKTexture(imageNamed: "drawImage")
        case .waiting:
            return SKTexture(imageNamed: "waitingImage")
        }
    }
}

class GameOverOverlay: SKSpriteNode {
    
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    

    lazy var gameOverLabel: SKSpriteNode = {
        let node = SKSpriteNode(texture: GameOverType.waiting.texture)
        node.zPosition = 14
        return node
//        let text = NSAttributedString(string: "Waiting opponent", attributes: [.font : UIFont(name: "Helvetica Neue Bold Italic", size: 32)!, .foregroundColor: UIColor.white])
//        let label = SKLabelNode(attributedText: text)
//        label.zPosition = 14
//        return label
    }()
    
    lazy var nextButton: SKSpriteNode = {
        let buttonNode = SKSpriteNode(imageNamed: "buttonTexture")
        buttonNode.size = CGSize(width: 300, height: 80)
        buttonNode.zPosition = 15
        buttonNode.name = "game over button"
        let text = NSAttributedString(string: "Next", attributes: [.font : UIFont(name: "Helvetica Neue Bold Italic", size: 24)!, .foregroundColor: UIColor.white])
        let label = SKLabelNode(attributedText: text)
        label.zPosition = 16
        label.name = "game over button label"
        label.position = CGPoint(x: 0, y: -label.frame.size.height/2)
        buttonNode.addChild(label)
        return buttonNode
    }()
    
    convenience init(sceneSize: CGSize, type: GameOverType) {
        self.init(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), size: sceneSize)
        self.zPosition = 14
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nextButton.position = CGPoint(x: 0, y: -self.size.height/2 + nextButton.size.height/2 + 100)
        gameOverLabel.texture = type.texture
        gameOverLabel.position = CGPoint(x: 0, y: gameOverLabel.size.height/2)
        self.addChild(gameOverLabel)
        self.addChild(nextButton)
    }
    
    
}

extension GameOverOverlay: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = self.scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["game over button label", "game over button"]) {
            self.delegate.switchState(state: .goToGame)
        }
    }
}
