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
        VStack(spacing: 4) {
            Text(entry.emoji)
                .font(.system(size: 40))
            
            Spacer()
            
            Text("Vibes: \(entry.pickCount)")
                .font(.caption2)
                .bold()
                .minimumScaleFactor(0.8)
                .foregroundColor(.white)
        }
        .padding(8)
    }
}
