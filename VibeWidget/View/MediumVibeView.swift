//
//  MediumVibeView.swift
//  VibeWidgetExtension
//
//  Created by Aviran Dabush on 22/10/2025.
//

import SwiftUI

struct MediumVibeView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            HStack {
                SmallVibeView(entry: entry)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 4)
                
                Divider()
                    .overlay(.gray)
                
                VibeSelectorView()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 4)
            }
            .opacity(entry.showStreak ? 0.2 : 1.0)
            
            if entry.showStreak {
                WidgetStreakView(count: entry.pickCount)
            }
        }
        .padding(4)
        .animation(.easeInOut(duration: 0.5), value: entry.showStreak)
    }
}

struct VibeSelectorView: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Pick your vibe")
                .foregroundStyle(.white)
                .font(.caption2)
                .bold()
                .minimumScaleFactor(0.8)
            
            HStack(spacing: 8) {
                VibeButtonView(vibe: .focus)
                VibeButtonView(vibe: .power)
                VibeButtonView(vibe: .sad)
            }
            HStack(spacing: 8) {
                VibeButtonView(vibe: .chill)
                VibeButtonView(vibe: .joy)
            }
        }
    }
}

struct VibeButtonView: View {
    let vibe: Vibe
    
    var body: some View {
        Button(intent: SelectVibeIntent(vibe: vibe)) {
            Text(vibe.emoji)
                .font(.title3)
                .padding(4)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
