//
//  ScoreNode.swift
//  Bwin
//
//  Created by Tanya Koldunova on 17.10.2022.
//

import SpriteKit


class ScoreNode: SKSpriteNode {
    
    private lazy var timer: TimerManager = {
        let timer = TimerManager(seconds: 90, at: scene)
        timer.delegate = self
        return timer
    }()

    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    lazy var youNode = createScoreFragment(name: "You")
    lazy var opponentNode = createScoreFragment(name: "Opponent")
    lazy var timeNode = createScoreFragment(name: "Time")
    
    convenience init() {
        self.init(imageNamed: "scoreTexture")
        self.size = CGSize(width: 274, height: 80)
        self.zPosition = 1
        self.name = "score node"
        //-self.size.height/2 + youNode.size.height/2 + 16
        //-self.size.height/2 + opponentNode.size.height/2 + 16
        //self.size.height/2 - timeNode.size.height/2 - 16
        youNode.position = CGPoint(x: -self.size.width/2 + youNode.size.width/2 + 12, y: 0)
        opponentNode.position = CGPoint(x: self.size.width/2 - opponentNode.size.width/2 - 12, y: 0)
        timeNode.position = CGPoint(x: 0, y: 0)
        self.addChild(youNode)
        self.addChild(opponentNode)
        self.addChild(timeNode)
    }
    
    func setUpTimer() {
        timer.startTimer()
    }
    
    func createScoreFragment(name: String) -> SKSpriteNode {
        let fragmentNode = SKSpriteNode(imageNamed: "scoreFragmentTexture")
        fragmentNode.size = CGSize(width: 79, height: 60)
        fragmentNode.name = name.lowercased() + "Node"
        fragmentNode.zPosition = 1
        let text = NSAttributedString(string: name, attributes: [.font : UIFont(name: "Danger on the Motorway", size: 12)!, .foregroundColor: UIColor.white])
        let titleLabel = SKLabelNode(attributedText: text)
        titleLabel.position = CGPoint(x: 0, y: fragmentNode.size.height/2 - 20)
        titleLabel.name = name.lowercased() + "TitleLabel"
        titleLabel.zPosition = 1
        fragmentNode.addChild(titleLabel)
        let valueText = NSAttributedString(string: name == "Time" ? "00:00" : "00", attributes: [.font : UIFont(name: "Danger on the Motorway", size: 16)!, .foregroundColor: UIColor.white])
        let valueLabel = SKLabelNode(attributedText: valueText)
        valueLabel.position = CGPoint(x: 0, y: -fragmentNode.size.height/2 + 8)
        valueLabel.name = name.lowercased() + "ValueLabel"
        valueLabel.zPosition = 1
        fragmentNode.addChild(valueLabel)
        return fragmentNode
    }
}

extension ScoreNode: TimerDelegate {
    func setUpTime(time: String) {
        let text = NSAttributedString(string: time, attributes: [.font : UIFont(name: "Danger on the Motorway", size: 16)!, .foregroundColor: UIColor.white])
        if let valueLabel = timeNode.childNode(withName: "timeValueLabel") as? SKLabelNode {
            valueLabel.attributedText = text
        }
    }
    
    func timeEnded() {
        playVibration()
        self.delegate.switchState(state: .gameOver)
    }
}

extension ScoreNode: Dependable {
    func receiveMessage<T>(with arguments: T) {
        if let argument = arguments as? (String, String) {
            if argument.0 == "you" {
                let text = NSAttributedString(string: argument.1, attributes: [.font : UIFont(name: "Danger on the Motorway", size: 16)!, .foregroundColor: UIColor.white])
                if let valueLabel = youNode.childNode(withName: "youValueLabel") as? SKLabelNode {
                    valueLabel.attributedText = text
                }
            } else if argument.0 == "opponent" {
                let text = NSAttributedString(string: argument.1, attributes: [.font : UIFont(name: "Danger on the Motorway", size: 16)!, .foregroundColor: UIColor.white])
                if let valueLabel = opponentNode.childNode(withName: "opponentValueLabel") as? SKLabelNode {
                    valueLabel.attributedText = text
                }
            }
        }
    }
}
