//
//  PlayingState.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import GameplayKit

class PlayingState: GKState {
    weak var gameSceneManager: GameSceneManager?
    lazy var backgroundNode: SKSpriteNode = createBackground()
    lazy var hoopNode = HoopNode()
    lazy var ballNode = BallNode()
    lazy var scoreNode = ScoreNode()
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
       
       
    }
    override func didEnter(from previousState: GKState?) {
        if previousState is GameOverState {
            return
        }
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scoreNode.position = CGPoint(x: 0, y: scene.size.height/2 - scoreNode.size.height/2 - 48)
        hoopNode.position = CGPoint(x: 0, y: scoreNode.frame.minY - hoopNode.size.height/2 - 8)
        ballNode.position =  CGPoint(x: 0, y: -scene.size.height/2+60+ballNode.size.width/2)
        gameSceneManager.toucheble.append(ballNode)
        gameSceneManager.updatable.append(hoopNode)
        gameSceneManager.goalDelegate = scoreNode
        scene.addChild(backgroundNode)
        scene.addChild(hoopNode)
        scene.addChild(ballNode)
        scene.addChild(scoreNode)
        scoreNode.setUpTimer()
    }

    
    override func willExit(to nextState: GKState) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
    }

}


extension PlayingState {
    func createBackground()->SKSpriteNode {
        guard let scene = gameSceneManager?.scene else {return SKSpriteNode()}
        let backgroundNode = SKSpriteNode(imageNamed: "backgroundTexture")
        backgroundNode.size = scene.size
        backgroundNode.zPosition = 1.0
        let court = SKSpriteNode(color: .clear, size: CGSize(width: backgroundNode.size.width, height: 20))
        court.zPosition = 2
        court.position = CGPoint(x: 0, y: backgroundNode.size.height/2 - backgroundNode.size.height*0.83 - court.size.height/2)
        court.physicsBody = SKPhysicsBody(rectangleOf: court.size)
        court.physicsBody?.isDynamic = false
        court.physicsBody?.categoryBitMask = PhysicsBitMask.secondGround.bitMask
        court.physicsBody?.collisionBitMask = PhysicsBitMask.ball.bitMask
        let ground = SKSpriteNode(color: .clear, size: CGSize(width: backgroundNode.size.width, height: 45))
        ground.position = CGPoint(x: 0, y: -backgroundNode.size.height/2 + ground.size.height/2)
        ground.zPosition = 2
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = PhysicsBitMask.ground.bitMask
        ground.physicsBody?.collisionBitMask = PhysicsBitMask.ball.bitMask
        
        
        backgroundNode.addChild(court)
        backgroundNode.addChild(ground)
        return backgroundNode
    }
   
}

