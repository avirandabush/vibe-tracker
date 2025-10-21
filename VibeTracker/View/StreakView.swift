//
//  StreakView.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import SwiftUI

struct StreakView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack {
                Text("🎉 Streak! 🎉")
                    .font(.title)
                    .bold()
                Text("You've hit a 7-vibe streak!")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .padding()
        }
        .shadow(radius: 4)
    }
}
