//
//  ContentView.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: VibeViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Pick your vibe")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                
                HStack(spacing: 12) {
                    ForEach(Vibe.allCases, id: \.self) { vibe in
                        VibeButton(vibe: vibe) {
                            withAnimation(.spring()) {
                                viewModel.selectVibe(vibe)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                if let selectedVibe = viewModel.selectedVibe {
                    Text("Your vibe today: \(selectedVibe.title)")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.top, 12)
                        .transition(.opacity.combined(with: .scale))
                } else {
                    Text("No vibe yet - pick one!")
                        .font(.headline)
                        .padding(.top, 12)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Text("You've picked \(viewModel.picksThisWeek) vibes this week.")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .padding(.top, 6)
                
                StreakProgressView(percentage: viewModel.streakProgressPercentage,
                                   streakGoal: viewModel.streakGoal,
                                   picksInCurrentStreak: viewModel.picksInCurrentStreak)
                    .padding(.horizontal, 100)
                    .padding(.vertical, 50)
            }
            
            if viewModel.showDuplicateToast {
                ToastView(text: "You already picked this vibe 🙂")
                    .animation(.easeInOut(duration: 0.3), value: viewModel.showDuplicateToast)
            }
            
            if viewModel.lastPickWasStreak {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .blur(radius: 8)
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.lastPickWasStreak)
                
                StreakView()
                    .frame(height: 180)
                    .padding(.horizontal)
                    .transition(.scale)
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                viewModel.refreshVibeState()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(VibeViewModel())
}
