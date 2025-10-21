//
//  VibeButton.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import SwiftUI

struct VibeButton: View {
    let vibe: Vibe
    let action: () -> Void
    
    @State private var pressed = false
    
    var body: some View {
        Button(action: {
            pressed = true
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { pressed = false }
        }) {
            VStack(spacing: 4) {
                Text(vibe.emoji)
                    .font(.largeTitle)
                    .padding(6)
                    .background(Circle().fill(.white.opacity(0.7)))
                Text(vibe.rawValue)
                    .foregroundStyle(.white)
                    .font(.caption2)
            }
            .padding(6)
            .scaleEffect(pressed ? 0.9 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
