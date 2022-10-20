//
//  BallNode.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit


class BallNode: SKSpriteNode {
    private var ballTouchPos: CGPoint?
    convenience init() {
        self.init(texture: UserDefaultsValues.currentBall.texture)
        self.size = CGSize(width: 100, height: 100)
        self.zPosition = 10
        self.physicsBody = SKPhysicsBody(circleOfRadius: 25/*self.size.width/2*/)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.restitution = 0.7
        self.physicsBody?.categoryBitMask = PhysicsBitMask.ball.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.ground.bitMask
        self.physicsBody?.contactTestBitMask = 0x0
        self.name = "ball"
    }
}

extension BallNode: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            if let touch = touches.first {
                ballTouchPos = touch.location(in: scene)
            }
        } else {
            ballTouchPos = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        guard let ballPos = ballTouchPos else {return}
        if let touch = touches.first {
            let touchPoint =  touch.location(in: scene)
            if let touchedNode = scene.atPoint(touchPoint) as? BallNode {
                print("not swipe")
                return
            }
            let x = getNeededX(point1: touchPoint, point2: ballPos, neededY: scene.size.height/2 - 100)
            applyAction(xPos: x)
        }
    }
    
    func getNeededX(point1: CGPoint, point2: CGPoint, neededY: CGFloat) -> CGFloat {
        let pointDifX = point2.x - point1.x
        let pointDifY = point2.y - point2.x
        let neededPointY = neededY - point1.y
        let x = (pointDifX*neededPointY/pointDifY)+point1.x
        return x
    }
    
    func applyAction(xPos: CGFloat) {
        guard let scene = scene as? GameScene else {return}
      //  let impulseAction = SKAction.applyImpulse(CGVector(dx: 0, dy: 135), at: CGPoint(x: 0, y: scene.size.height/2 - self.size.height/2), duration: 0.01)
        let impulseAction = SKAction.run {
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 138), at: CGPoint(x: 0, y: scene.size.height/2 - self.size.height/2))
        }
  //      impulseAction.speed = 0.3
        let groupAction = SKAction.group([impulseAction, SKAction.moveTo(x: xPos, duration: 0.5), SKAction.resize(toWidth: 50, height: 50, duration: 1.0)])
        scene.gameManager.toucheble.removeAll { node in
            if let node = node as? SKNode {
                return node.name == "ball"
            } else {
                return false
            }
        }
        fallSoundPlay()
        self.run(SKAction.sequence([groupAction, SKAction.run {
            self.physicsBody?.collisionBitMask = PhysicsBitMask.hoop.bitMask | PhysicsBitMask.ground.bitMask | PhysicsBitMask.secondGround.bitMask
            self.physicsBody?.contactTestBitMask = PhysicsBitMask.goal.bitMask
            self.zPosition = 4
            let ball = BallNode()
            ball.position = CGPoint(x: 0, y: -scene.size.height/2+60+ball.size.width/2)
            scene.addChild(ball)
            scene.gameManager.toucheble.append(ball)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.run(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()]))
            })
        }]))
    }
}
