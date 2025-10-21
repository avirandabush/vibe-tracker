//
//  VibeTrackerApp.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import SwiftUI

@main
struct VibeTrackerApp: App {
    @StateObject private var viewModel = VibeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
