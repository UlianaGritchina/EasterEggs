//
//  OpenEasterEggsOnDeviceShakeModifier.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 13.09.2025.
//

import SwiftUI

struct OpenEasterEggsOnDeviceShakeModifier: ViewModifier {
    
    // MARK: State
    
    @State private var isOpenEasterEggsView = false
    
    // MARK: Constants
    
    private let sceneStyle: SceneStyle
    
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

// MARK: - Extensions

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
    ///Opens the EasterEggsView when the user shakes the phone.
    func onShakeOpenEasterEggs(sceneStyle: SceneStyle = .base) -> some View {
        self.modifier(OpenEasterEggsOnDeviceShakeModifier(sceneStyle: sceneStyle))
    }
}
