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
        .padding(8)
    }
}

struct VibeSelectorView: View {
    var body: some View {
        VStack(spacing: 6) {
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
