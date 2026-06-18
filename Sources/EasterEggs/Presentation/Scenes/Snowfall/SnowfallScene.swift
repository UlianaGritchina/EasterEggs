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
}
