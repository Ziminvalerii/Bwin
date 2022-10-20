//
//  GameViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var connectionManager: PeerConnectivityManager!
    var router: RouterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                scene.gameManager = GameSceneManager(scene: scene)
                scene.parentVC = self
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
        connectionManager.recieveDelegate = self
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: PeerRecieveDelegate {
    func recieved(message: PeerConnectionMessage) {
        switch message {
        case .connecting(let connectingModel):
            return
        case .playing(let playingModel):
            DispatchQueue.main.async {
                if let view = self.view as! SKView? {
                    guard let scene = view.scene as? GameScene else {return}
                    guard let scoreNode = scene.childNode(withName: "score node") as? ScoreNode else {return}
                    scene.gameManager.opponentGoalCount = playingModel.score
                    scoreNode.receiveMessage(with: ("opponent", scene.gameManager.opponentGoalCount.description))
                }
            }
            
        case .gameOver:
            DispatchQueue.main.async {
                self.connectionManager.disconnect()
            }
        }
    }
}
