//
//  VibeWidget.swift
//  VibeWidget
//
//  Created by Aviran Dabush on 21/10/2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    private func loadVibeData() -> (emoji: String, count: Int) {
        let store = VibeStore.shared
        let selectedVibe = store.loadSelectedVibe()
        let count = store.picksThisWeek()
        
        let emoji = selectedVibe?.emoji ?? "🤔"
        return (emoji: emoji, count: count)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        let data = loadVibeData()
        return SimpleEntry(date: Date(), emoji: data.emoji, pickCount: data.count, showStreak: false)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = loadVibeData()
        let entry = SimpleEntry(date: Date(), emoji: data.emoji, pickCount: data.count, showStreak: false)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        var entries: [SimpleEntry] = []
        let data = loadVibeData()
        let picksThisWeek = data.count
        let isStreak = picksThisWeek > 0 && picksThisWeek % 7 == 0
        let currentEntry = SimpleEntry(date: Date(),
                                       emoji: data.emoji,
                                       pickCount: data.count,
                                       showStreak: isStreak)
        entries.append(currentEntry)

        if isStreak {
            let hideStreakDate = Calendar.current.date(byAdding: .second, value: 3, to: Date()) ?? Date()
            
            let hideEntry = SimpleEntry(date: hideStreakDate,
                                        emoji: data.emoji,
                                        pickCount: data.count,
                                        showStreak: false)
            entries.append(hideEntry)
            
            let timeline = Timeline(entries: entries, policy: .after(hideEntry.date))
            completion(timeline)
            return
        }

        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let pickCount: Int
    let showStreak: Bool
    
    let streakGoal = 7
    var picksInCurrentStreak: Int {
        let picks = pickCount % streakGoal
        return picks == 0 && pickCount > 0 ? streakGoal : picks
    }
    
    var streakProgressPercentage: Double {
        return Double(picksInCurrentStreak) / Double(streakGoal)
    }
    
    var streakStatusText: String {
        return "\(picksInCurrentStreak) / \(streakGoal)"
    }
}

// MARK: - View

struct VibeWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallVibeView(entry: entry)
                .containerBackground(.black.gradient, for: .widget)
            
        case .systemMedium:
            MediumVibeView(entry: entry)
                .containerBackground(.black.gradient, for: .widget)
            
        default:
            SmallVibeView(entry: entry)
                .containerBackground(.black.gradient, for: .widget)
        }
    }
}

struct VibeWidget: Widget {
    let kind: String = "VibeWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                VibeWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                VibeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview

#Preview(as: .systemSmall) {
    VibeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "💪", pickCount: 15, showStreak: false)
}

#Preview(as: .systemMedium) {
    VibeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😂", pickCount: 27, showStreak: false)
}
