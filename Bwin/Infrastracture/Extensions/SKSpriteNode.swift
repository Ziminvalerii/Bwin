//
//  SKSpriteNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 05.10.2022.
//

import SpriteKit

extension SKSpriteNode {
    
    func addGlow(radius: Float = 60) {
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = false
        effectNode.blendMode = .add
        effectNode.name = "glow node"
        addChild(effectNode)
        effectNode.run(SKAction.fadeIn(withDuration: 0.1))
        let effect = SKSpriteNode(texture: texture)
        effect.color = SKColor.white
        effect.colorBlendFactor = 1
        effectNode.addChild(effect)
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
    }
}
