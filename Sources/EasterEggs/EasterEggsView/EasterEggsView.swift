//
//  File.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 11.09.2025.
//

import SwiftUI
import SpriteKit

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
        ZStack {
            SpriteView(scene: eggsScene)
                .overlay(alignment: .topTrailing) { closeButton }
        }
        .ignoresSafeArea()
    }
}

extension EasterEggsView {
    private var eggsScene: SKScene {
        let scene = EasterEggsScene(sceneStyle: viewModel.sceneStyle)
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    
    private var closeButton: some View {
        Button(action: { dismiss()} ) {
            Text("Close")
                .foregroundColor(.accentColor)
                .font(.headline)
                .padding(4)
                .background { Color.white.cornerRadius(5) }
        }
        .padding(.top, 50)
        .padding(.trailing, 20)
    }
}
