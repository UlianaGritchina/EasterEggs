//
//  View+Extension.swift
//  EasterEggs
//
//  Created by Ульяна Гритчина on 18.06.2026.
//

import SwiftUI

public extension View {
    ///Opens the EasterEggsView when the user shakes the phone.
    func onShakeOpenEasterEggs(sceneStyle: SceneStyle = .base) -> some View {
        self.modifier(OpenEasterEggsOnDeviceShakeModifier(sceneStyle: sceneStyle))
    }
}
