//
//  UIWindow+Extension.swift
//  EasterEggs
//
//  Created by Ульяна Гритчина on 18.06.2026.
//

import UIKit

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(
                name: UIDevice.deviceDidShakeNotification,
                object: nil
            )
        }
    }
}
