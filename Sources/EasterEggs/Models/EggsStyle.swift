//
//  File.swift
//  EasterEggs
//
//  Created by Uliana Gritchina on 11.09.2025.
//

import Foundation

enum EggsStyle: String {
    case base
    case winter
    case spring
    case summer
    case autumn
    case halloween
    case christmas
    
    var backgroundImage: String {
        switch self {
        case .base: "summerBack"
        case .winter: "winterBack"
        case .spring: "springBack"
        case .summer: "summerBack"
        case .autumn:  "autumnBack"
        case .halloween: "halloweenBack"
        case .christmas: "christmasBack"
        }
    }
}
