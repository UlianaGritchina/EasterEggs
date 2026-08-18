//
//  SceneStyleTests.swift
//  EasterEggs
//
//  Created by Ульяна Гритчина on 19.06.2026.
//

import Testing
@testable import EasterEggs

@Suite struct SceneStyleTests {
    
    @Suite(.tags(.customValue)) struct CustomValue {
        @Test
        func checkIsCustom() {
            let style = SceneStyle.custom(backgroundImageName: "", eggsImages: [])
            #expect(style.isCustom)
        }
        
        @Test("Check isCustom value for base styles", arguments: [
            SceneStyle.base,
            SceneStyle.autumn
        ])
        func checkIsNotCustom(style: SceneStyle) {
            #expect(!style.isCustom)
        }
    }
    
}

extension Tag {
    @Tag static var customValue: Self
}
