//
//  ToastView.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import SwiftUI

struct ToastView: View {
    let text: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.subheadline)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.9))
                .foregroundColor(.black)
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding(.bottom, 40)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}
