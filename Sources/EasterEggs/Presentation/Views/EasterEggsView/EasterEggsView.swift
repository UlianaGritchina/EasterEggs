//
//  File.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 11.09.2025.
//

import SwiftUI
import SpriteKit
/// A SwiftUI view that displays an interactive Easter Eggs scene.
public struct EasterEggsView: View {
    
    // MARK: Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: StateObject
    
    @StateObject private var viewModel: ViewModel
    
    public init(sceneStyle: SceneStyle = .base) {
        let vm = ViewModel(sceneStyle: sceneStyle)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        SpriteView(scene: eggsScene)
            .ignoresSafeArea()
            .overlay(alignment: .topTrailing) { closeButton }
            .preferredColorScheme(.light)
    }
}

extension EasterEggsView {
    private var eggsScene: SKScene {
        let scene = EasterEggsScene(sceneStyle: viewModel.sceneStyle)
        scene.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        scene.scaleMode = .fill
        return scene
    }
    
    @ViewBuilder private var closeButton: some View {
        if #available(iOS 26, *) {
            xmarkButtonGlass
        } else {
            xmarkButtonMaterial
        }
    }
    
    private var xmarkButtonMaterial: some View {
        Button(action: { dismiss()} ) {
            Image(systemName: "xmark")
                .foregroundStyle(.white)
                .padding(8)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .padding(.trailing, 20)
    }
    
    
    @available(iOS 26.0, *)
    private var xmarkButtonGlass: some View {
        Button(action: { dismiss()} ) {
            Image(systemName: "xmark")
                .padding(8)
                .foregroundStyle(.gray)
                .glassEffect()
        }
        .padding(.trailing, 10)
    }
}
