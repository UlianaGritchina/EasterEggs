//
//  SKScene+Extension.swift
//  EasterEggs
//
//  Created by Ульяна Гритчина on 18.06.2026.
//

import SpriteKit

extension SKScene {
    func addSnowfall() {
        guard
            let emitterPath = Bundle.module.path(forResource: "Snow", ofType: "sks"),
            let snowNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as? SKEmitterNode,
            let snowflakeImage = UIImage(named: "spark", in: .module, with: nil)
        else { return }

        snowNode.position = CGPoint(x: frame.midX, y: frame.height)
        snowNode.particleTexture = SKTexture(image: snowflakeImage)
        snowNode.name = "snowNode"
        snowNode.targetNode = self

        addChild(snowNode)
    }
}
