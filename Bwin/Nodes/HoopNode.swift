//
//  HoopNode.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import SpriteKit

class HoopNode: SKSpriteNode {
    let currentTime: TimeInterval = Date().timeIntervalSince1970
  //  var actionSpeed: TimeInterval = 10.0
    var physicsNode = [SKSpriteNode]()
    var moveAction: SKAction?
    var reversed: SKAction?
    var actionSpeed: CGFloat = 0.5
    
    lazy var backHoopNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "backHoop")
        node.size = CGSize(width: 85, height: 11)
        node.zPosition = 1
      //  node.zPosition = 3
       // let physicNode = SKSpriteNode(color: .red, size: CGSize(width: 25, height: 10))
        return node
    }()
    
    lazy var frontHoopNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "frontHoop")
        node.size = CGSize(width: 85, height: 61)
        node.zPosition = 5
        return node
    }()
    
    
    convenience init() {
        self.init(imageNamed: "standTexture")
        self.size = CGSize(width: 140, height: 97)
        self.zPosition = 2
        self.name = "hoop"
        backHoopNode.position = CGPoint(x: 0, y: -28)
        frontHoopNode.position = CGPoint(x: 0, y: -58.5)
        self.addChild(backHoopNode)
        self.addChild(frontHoopNode)
        setUpPhysics()
    }
    
    func setUpPhysics() {
        let backPhysicNode = createPhysicNodes(pos: CGPoint(x: -backHoopNode.size.width/2 + 9.5, y: 0), rotation: 13.0)
        let backPhysicNode2 = createPhysicNodes(pos: CGPoint(x: backHoopNode.size.width/2 - 9.5, y: 0), rotation: -13)
        backHoopNode.addChild(backPhysicNode)
        backHoopNode.addChild(backPhysicNode2)
        let goalNode = createGoalNode()
        //GPoint(x: self.size.width/2 + 12.5, y: self.frame.minY+12.5)
    }
    
    func createGoalNode() {
        let node = SKSpriteNode(color: .clear, size: CGSize(width: 55, height: 5))
        node.position = CGPoint(x: 0, y: 0)
        node.name = "hoop physics"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsBitMask.goal.bitMask
        node.physicsBody?.contactTestBitMask = PhysicsBitMask.ball.bitMask
        frontHoopNode.addChild(node)
        physicsNode.append(node)
    }
    
    func createPhysicNodes(pos: CGPoint, rotation: CGFloat) -> SKSpriteNode {
        let node = SKSpriteNode(color: .clear, size: CGSize(width: 12, height: 10))
        node.zRotation = rotation
        node.position = pos
        node.name = "hoop physics"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsBitMask.hoop.bitMask
        node.physicsBody?.collisionBitMask = PhysicsBitMask.ball.bitMask
        physicsNode.append(node)
        return node
    }
}

extension HoopNode: Updatable {
    func update(timeInterval: TimeInterval) {
        guard let scene = scene else {return}
        self.position.x += actionSpeed
        if self.position.x > scene.size.width/2 - self.size.width/2 {
            actionSpeed = -actionSpeed
        }
        if self.position.x < -scene.size.width/2 + self.size.width/2 {
            actionSpeed = -1*actionSpeed
            actionSpeed += 0.1
        }
       
        
    }
}
