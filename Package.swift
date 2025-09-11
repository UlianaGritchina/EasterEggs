// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasterEggs",
    
    platforms: [.iOS(.v15)],
    
    products: [
        .library(
            name: "EasterEggs",
            targets: ["EasterEggs"]),
    ],
    targets: [
        .target(name: "EasterEggs", resources: [.process("Resources/")]),
    ]
)

//private let month = NSCalendar.current.component(.month, from: Date())
//private let day = NSCalendar.current.component(.day, from: Date())
//private let halloweenRange = 22...31
//private let christamsDecemberRange = 16...31
//private let christamsJanRange = 1...7
//
//private init() { }
//
//var eggStyle: (backgroundImage: EggBackground, eggsSet: EggsSet) {
//    switch month {
//    case 1, 2, 12:
//        if month == 12 && christamsDecemberRange.contains(day) {
//            return (.christams, .christmas)
//        } else if month == 1 && christamsJanRange.contains(day) {
//            return (.christams, .christmas)
//        } else {
//            return (.winter, .base)
//        }
//    case 3, 4, 5:
//        return (.spring, .base)
//
//    case 6, 7, 8:
//        return (.summer, .base)
//
//    case 9, 10, 11:
//        if month == 10 && halloweenRange.contains(day) {
//            return (.halloween, .halloween)
//        } else {
//            return (.autumn, .base)
//        }
//    default:
//        return (.summer, .base)
//    }
//}
//}
