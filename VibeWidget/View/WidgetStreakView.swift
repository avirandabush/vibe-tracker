//
//  WidgetStreakView.swift
//  VibeWidgetExtension
//
//  Created by Aviran Dabush on 22/10/2025.
//

import SwiftUI

struct WidgetStreakView: View {
    var count: Int
    var isSmall: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack {
                Text("🎉 Milestone! 🎉")
                    .font(isSmall ? .caption : .headline)
                    .foregroundColor(.yellow)
                    .transition(.opacity.combined(with: .scale))
                Text("\(count) Picks Total")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 8)
            }
        }
    }
}
