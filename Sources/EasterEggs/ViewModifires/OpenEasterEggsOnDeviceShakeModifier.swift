//
//  OpenEasterEggsOnDeviceShakeModifier.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 13.09.2025.
//

import SwiftUI

struct OpenEasterEggsOnDeviceShakeModifier: ViewModifier {
    @State private var isOpenEasterEggsView = false
    
    let sceneStyle: SceneStyle
    
    init(sceneStyle: SceneStyle) {
        self.sceneStyle = sceneStyle
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                isOpenEasterEggsView = true
            }
            .fullScreenCover(isPresented: $isOpenEasterEggsView) {
                EasterEggsView(sceneStyle: sceneStyle)
            }
    }
}

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}

public extension View {
    func onShakeOpenEasterEggs(sceneStyle: SceneStyle = .base) -> some View {
        self.modifier(OpenEasterEggsOnDeviceShakeModifier(sceneStyle: sceneStyle))
    }
}
