//
//  SceneStyle.swift
//  SceneStyle
//
//  Created by Uliana Gritchina on 11.09.2025.
//

import Foundation

/// Defines the visual appearance of `EasterEggsView`.
///
/// `SceneStyle` determines the background image and the collection of egg
/// images used in the scene.
///
/// ## Built-in styles
///
/// - `.base` – Default appearance.
/// - `.christmas` – Christmas-themed background and eggs.
/// - `.halloween` – Halloween-themed background and eggs.
/// - `.watermelons` – Watermelon-themed background and eggs.
///
/// ```swift
/// EasterEggsView(sceneStyle: .christmas)
/// ```
///
/// ## Custom style
///
/// Create a custom theme by providing your own background and egg images.
///
/// ```swift
/// EasterEggsView
///     sceneStyle: .custom(
///         backgroundImageName: "yourCustomBackground",
///         eggsImages: [
///             "yourCustomEgg1",
///             "yourCustomEgg2",
///             "yourCustomEgg3"
///         ]
///     )
/// )
/// ```
///
/// Parameters:
///  - backgroundImageName: The name of the background image in your app's asset catalog or bundle.
///  - eggsImages: An array of image names that will be randomly selected when creating eggs.
///
/// > Important: All custom images must be included in your application's
/// > asset catalog or bundle, and their names must exactly match the
/// > values passed to `SceneStyle.custom`.
public enum SceneStyle: Equatable, Sendable {
    
    /// Default style with a summer-themed background and standard eggs.
    case base
    
    /// Winter-themed style with a snowy background and default eggs.
    case winter
    
    /// Spring-themed style with a spring background and default eggs.
    case spring
    
    /// Summer-themed style with a summer background and default eggs.
    case summer
    
    /// Autumn-themed style with an autumn background and default eggs.
    case autumn
    
    /// Halloween-themed style with spooky background and Halloween eggs.
    case halloween
    
    /// Christmas-themed style with festive background and Christmas eggs.
    case christmas
    
    /// Watermelon-themed style with playful background and watermelon eggs.
    case watermelons
    
    /// A custom scene style using images provided by the host application.
    ///
    /// Parameters:
    ///  - backgroundImageName: The name of the background image.
    ///  - eggsImages: An array of image names used for randomly generated eggs.
    case custom(backgroundImageName: String, eggsImages: [String])
    
    var backgroundImage: String {
        switch self {
        case .base: "summerBack"
        case .winter: "winterBack"
        case .spring: "springBack"
        case .summer: "summerBack"
        case .autumn:  "autumnBack"
        case .halloween: "halloweenBack"
        case .christmas: "christmasBack"
        case .watermelons: "watermelonsBack"
        case .custom(let backgroundImageName, _): backgroundImageName
        }
    }
    
    var easterEggsImagesSet: [String] {
        switch self {
        case .base, .winter, .spring, .summer, .autumn:
            ["egg1-base", "egg2-base", "egg3-base", "egg4-base", "egg5-base",
             "egg6-base", "egg7-base", "egg8-base", "egg9-base", "egg10-base"]
            
        case .halloween:
            ["egg1-halloween", "egg2-halloween", "egg3-halloween", "egg4-halloween", "egg5-halloween",
             "egg6-halloween", "egg7-halloween", "egg8-halloween", "egg9-halloween", "egg10-halloween"]
            
        case .christmas:
            ["egg1-christmas", "egg2-christmas", "egg3-christmas", "egg4-christmas", "egg5-christmas",
             "egg6-christmas", "egg7-christmas", "egg8-christmas", "egg9-christmas", "egg10-christmas",
             "egg11-christmas"]
            
        case .watermelons:
            ["egg1-watermelons", "egg2-watermelons", "egg3-watermelons", "egg4-watermelons", "egg5-watermelons",
             "egg6-watermelons", "egg7-watermelons", "egg8-watermelons", "egg9-watermelons", "egg10-watermelons"]
            
        case .custom(_, let eggsImages):
            eggsImages
        }
    }
    
    var isCustom: Bool {
        switch self {
        case .custom(_, _):  true
        default: false
        }
    }
}
