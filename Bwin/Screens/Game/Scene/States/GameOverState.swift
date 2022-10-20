//
//  GameOverState.swift
//  Bwin
//
//  Created by Tanya Koldunova on 17.10.2022.
//

import GameplayKit

class GameOverState: GKState {
    weak var gameSceneManager: GameSceneManager?
    var gameOverOverlay: GameOverOverlay!
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
        guard let scene = gameSceneManager.scene else {return}
     
       
    }
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
       
        let type: GameOverType = gameSceneManager.goalsCount == gameSceneManager.opponentGoalCount ? .draw : gameSceneManager.goalsCount > gameSceneManager.opponentGoalCount ? .win : .loose
        if gameSceneManager.goalsCount > UserDefaultsValues.bestScore {
            UserDefaultsValues.bestScore = gameSceneManager.goalsCount
        }
        gameOverOverlay = GameOverOverlay(sceneSize: scene.size, type: type)
        if type == .win {
            UserDefaultsValues.coinsCount += UserDefaultsValues.stake
        } else if type == .loose {
            UserDefaultsValues.coinsCount -= UserDefaultsValues.stake
        }
        let score = scene.childNode(withName: "score node")
        score?.zPosition = 18
        gameSceneManager.toucheble.append(gameOverOverlay)
        scene.addChild(gameOverOverlay)
    }

    
    override func willExit(to nextState: GKState) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.parentVC?.router.dissmiss()
    }
}
