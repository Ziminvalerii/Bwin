//
//  GameSceneManager.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit

class GameSceneManager: NSObject, GameSceneManagerProtocol {    
    weak var scene: GameScene?
    weak var contactManager: ContactManager?
    var parentViewController: GameViewController!
    var toucheble: [Touchable] = [Touchable]()
    var updatable: [Updatable] = [Updatable]()
    var endless: [Endless] = [Endless]()
    var goalsCount = 0 {
        didSet {
            var description = goalsCount.description
            if description.count == 1 {
                description = "0"+description
            }
            goalDelegate?.receiveMessage(with: ("you", description))
        }
    }
    var opponentGoalCount = 0
    var goalDelegate: Dependable?
    
    required init?(scene : GameScene) {
        self.scene = scene
        self.scene?.backgroundColor = .white
        super.init()
        preparePhysicsForWold(for: scene)
    }
    
    func preparePhysicsForWold(for scene: SKScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -12.0)
        scene.physicsWorld.contactDelegate = self
    }
}

extension GameSceneManager: Dependable {
    func receiveMessage<T>(with arguments: T) {
    }
}

extension GameSceneManager : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
        if collision == PhysicsBitMask.goal.bitMask | PhysicsBitMask.ball.bitMask {
            playPopVibration()
            goalsCount += 1
            let model = PeerConnectionMessage.playing(PlayingModel(score: goalsCount))
            scene?.parentVC?.connectionManager.send(message: model)
            print(goalsCount)
        }
    }
}

