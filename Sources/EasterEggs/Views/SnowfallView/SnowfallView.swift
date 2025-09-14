//
//  SnowfallView.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 14.09.2025.
//

import SpriteKit
import SwiftUI

public struct SnowfallView: View {
    public var body: some View {
        SpriteView(scene: SnowfallScene(), options: [.allowsTransparency])
    }
    
    public init() { }
}

#Preview {
    SnowfallView()
}
