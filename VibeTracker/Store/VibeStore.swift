//
//  VibeStore.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import Foundation

enum VibeSaveResult {
    case newSelection
    case duplicate
    case failed
}

final class VibeStore {
    static let shared = VibeStore()

    private let appGroupID = "group.com.gmail.avirandabush.vibetracker"

    private var defaults: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }

    private let selectedKey = "selectedVibe"
    private let picksKey = "vibePicks"

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}
    
    func saveSelectedVibe(_ vibe: Vibe) -> VibeSaveResult {
        guard let defaults = defaults else { return .failed }
        
        if let data = defaults.data(forKey: selectedKey),
           let currentVibe = try? decoder.decode(Vibe.self, from: data), currentVibe == vibe {
            return .duplicate
        }
        
        guard let data = try? encoder.encode(vibe) else { return .failed }
        defaults.set(data, forKey: selectedKey)
        
        var picks = loadPickDates()
        picks.append(Date())
        savePickDates(picks)
        
        return .newSelection
    }

    func loadSelectedVibe() -> Vibe? {
        guard let defaults = defaults, let data = defaults.data(forKey: selectedKey) else { return nil }
        return try? decoder.decode(Vibe.self, from: data)
    }

    private func savePickDates(_ dates: [Date]) {
        guard let defaults = defaults else { return }
        let iso = dates.map { ISO8601DateFormatter().string(from: $0) }
        defaults.set(iso, forKey: picksKey)
    }

    private func loadPickDates() -> [Date] {
        guard let defaults = defaults else { return [] }
        guard let iso = defaults.stringArray(forKey: picksKey) else { return [] }
        let fmt = ISO8601DateFormatter()
        return iso.compactMap { fmt.date(from: $0) }
    }

    func picksThisWeek() -> Int {
        let dates = loadPickDates()
        let start = Date().startOfWeek
        return dates.filter { $0 >= start }.count
    }

    func allPickDates() -> [Date] { loadPickDates() }
}
