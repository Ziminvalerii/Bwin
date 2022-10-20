//
//  StartScene.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit

class StartScene: SKScene {
    
    lazy var background: SKSpriteNode = createBackground()
    var j = 0

    override func sceneDidLoad() {
        self.size = UIScreen.main.bounds.size
        self.addChild(background)
        
    }
    
    override func didMove(to view: SKView) {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(setUpAction), SKAction.wait(forDuration: 0.8)])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func setUpAction() {
        let ball1 = BallNode()
        ball1.physicsBody?.collisionBitMask = PhysicsBitMask.hoop.bitMask | PhysicsBitMask.ground.bitMask | PhysicsBitMask.secondGround.bitMask
        var mult = j%2 == 0 ? -1 : 1
        ball1.position = CGPoint(x: self.size.width/2 * CGFloat(mult), y: 250)
        self.addChild(ball1)
        j += 1
        ball1.run(SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 20 * -mult, dy: 40), duration: 0.1), SKAction.wait(forDuration: 1.3), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
    }
    
    func createBackground() -> SKSpriteNode{
        let background = SKSpriteNode(imageNamed: "startBackground")
        background.size = self.size
        background.zPosition = 1.0
        let court = SKSpriteNode(color: .clear, size: CGSize(width: background.size.width, height: 20))
        court.zPosition = 2
        court.position = CGPoint(x: 0, y: background.size.height/2 - background.size.height*0.85 - court.size.height/2)
        court.physicsBody = SKPhysicsBody(rectangleOf: court.size)
        court.physicsBody?.isDynamic = false
        court.physicsBody?.categoryBitMask = PhysicsBitMask.secondGround.bitMask
        court.physicsBody?.collisionBitMask = PhysicsBitMask.ball.bitMask
        background.addChild(court)
        return background
    }
}
