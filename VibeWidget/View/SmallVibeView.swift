//
//  SmallVibeView.swift
//  VibeWidgetExtension
//
//  Created by Aviran Dabush on 22/10/2025.
//

import SwiftUI

struct SmallVibeView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                Text(entry.emoji)
                    .font(.system(size: 40))
                
                Spacer()
                
                Text("Vibes this week: \(entry.pickCount)")
                    .font(.caption2)
                    .bold()
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.white)
                
                WidgetProgressView(percentage: entry.streakProgressPercentage,
                                   streakStatusText: "streak: \(entry.streakStatusText)")
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            .opacity(entry.showStreak ? 0.2 : 1.0)
            
            if entry.showStreak {
                WidgetStreakView(count: entry.pickCount, isSmall: true)
            }
        }
        .padding(4)
        .animation(.easeInOut(duration: 0.5), value: entry.showStreak)
    }
}
