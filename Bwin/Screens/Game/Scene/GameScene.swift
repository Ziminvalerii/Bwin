//
//  GameScene.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    weak var parentVC: GameViewController?
    var gameManager: GameSceneManager!
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        PlayingState(gameSceneManager: gameManager),
        GameOverState(gameSceneManager: gameManager)
    ])
    
    override func sceneDidLoad() {
        self.size = UIScreen.main.bounds.size
    }
    
    override func didMove(to view: SKView) {
        stateMachine.enter(PlayingState.self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { node in
            node.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { node in
            node.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { node in
            node.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { node in
            node.touchesCancelled(touches, with: event)
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.updatable.forEach { node in
            node.update(timeInterval: currentTime)
        }
    }
}

extension GameScene: Dependable {
    func switchState(state: GameStates) {
        if state == .gameOver {
            congratulationSoundPlay()
            parentVC?.connectionManager.send(message: .gameOver)
            stateMachine.enter(GameOverState.self)
        } else if state == .goToGame {
            stateMachine.enter(PlayingState.self)
        }
    }
}
