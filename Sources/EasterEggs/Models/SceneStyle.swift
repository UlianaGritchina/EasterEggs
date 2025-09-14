//
//  SceneStyle.swift
//  SceneStyle
//
//  Created by Uliana Gritchina on 11.09.2025.
//

import Foundation

public enum SceneStyle: Equatable {
    case base
    case winter
    case spring
    case summer
    case autumn
    case halloween
    case christmas
    case watermelons
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
