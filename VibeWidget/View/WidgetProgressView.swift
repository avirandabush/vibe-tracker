//
//  WidgetProgressView.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 22/10/2025.
//

import SwiftUI

struct WidgetProgressView: View {
    let percentage: Double
    let streakStatusText: String
    let height: CGFloat = 16
    let backgroundColor = Color.white.opacity(0.3)
    let progressColor = Color.blue
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                Capsule()
                    .fill(backgroundColor)
                
                Capsule()
                    .fill(progressColor)
                    .frame(width: geometry.size.width * CGFloat(percentage))
                
                Text(streakStatusText)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(height: height)
        .animation(.linear(duration: 0.5), value: percentage)
    }
}
