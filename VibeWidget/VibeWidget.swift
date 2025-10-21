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
        let count = store.allPickDates().count
        
        let emoji = selectedVibe?.emoji ?? "🤔"
        return (emoji: emoji, count: count)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        let data = loadVibeData()
        return SimpleEntry(date: Date(), emoji: data.emoji, pickCount: data.count)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = loadVibeData()
        let entry = SimpleEntry(date: Date(), emoji: data.emoji, pickCount: data.count)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let data = loadVibeData()
        let entry = SimpleEntry(date: Date(), emoji: data.emoji, pickCount: data.count)
        
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let pickCount: Int
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
    SimpleEntry(date: .now, emoji: "💪", pickCount: 15)
}

#Preview(as: .systemMedium) {
    VibeWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😂", pickCount: 27)
}
