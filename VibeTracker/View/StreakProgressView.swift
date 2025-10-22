//
//  StreakProgressView.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 22/10/2025.
//

import SwiftUI

struct StreakProgressView: View {
    let percentage: Double
    let streakGoal: Int
    let picksInCurrentStreak: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.1), lineWidth: 15)
            
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.5), value: percentage)
            
            VStack {
                Text("Streak")
                    .font(.largeTitle)
                Text("\(picksInCurrentStreak) / \(streakGoal)")
                    .font(.system(size: 30))
                    .bold()
            }
            .foregroundStyle(.white)
            .fontDesign(.rounded)
        }
    }
}
