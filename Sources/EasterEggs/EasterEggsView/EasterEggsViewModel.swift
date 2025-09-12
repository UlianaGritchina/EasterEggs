//
//  File.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 12.09.2025.
//

import Foundation

extension EasterEggsView {
    @MainActor final class ViewModel: ObservableObject {
        let sceneStyle: SceneStyle
        
        init(sceneStyle: SceneStyle) {
            self.sceneStyle = sceneStyle
        }
    }
}
