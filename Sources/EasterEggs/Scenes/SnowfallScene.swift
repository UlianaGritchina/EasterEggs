//
//  File.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 14.09.2025.
//

import SpriteKit

class SnowfallScene: SKScene {
    public override func sceneDidLoad() {
        size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scaleMode = .aspectFill
        backgroundColor = .clear
        zPosition = -1
        addSnowfall()
    }
    
    private func addSnowfall() {
        if let emitterPath: String = Bundle.module.path(forResource: "Snow", ofType: "sks"),
           let snowNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as? SKEmitterNode,
           let snowflakeImage = UIImage(named: "spark", in: .module, with: nil) {
            snowNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.height)
            snowNode.particleTexture = SKTexture(image: snowflakeImage)
            snowNode.name = "snowNode"
            snowNode.scene?.backgroundColor = .clear
            snowNode.targetNode = self
            addChild(snowNode)
        }
    }
}
