//
//  Vibe.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import Foundation
import AppIntents

enum Vibe: String, CaseIterable, Codable, Sendable {
    case focus = "Focus"
    case power = "Power"
    case sad = "Sad"
    case chill = "Chill"
    case joy = "Joy"

    var emoji: String {
        switch self {
        case .focus: return "🧠"
        case .power: return "💪"
        case .sad: return "😥"
        case .chill: return "😴"
        case .joy: return "😂"
        }
    }

    var title: String { "\(emoji) \(rawValue)" }
}

extension Vibe: AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Vibe"
    
    static var caseDisplayRepresentations: [Vibe : DisplayRepresentation] = [
        .focus: "Focus",
        .power: "Power",
        .sad: "Sad",
        .chill: "Chill",
        .joy: "Joy"
    ]
}
