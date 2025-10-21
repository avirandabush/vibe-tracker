//
//  VibeViewModel.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import Foundation
import Combine
import WidgetKit

final class VibeViewModel: ObservableObject {
    @Published var selectedVibe: Vibe?
    @Published var picksThisWeek: Int = 0
    @Published var showDuplicateToast = false
    @Published var lastPickWasMilestone: Bool = false
    
    private let store: VibeStore
    
    init(store: VibeStore = .shared) {
        self.store = store
        self.selectedVibe = store.loadSelectedVibe()
        self.picksThisWeek = store.picksThisWeek()
    }
    
    func selectVibe(_ vibe: Vibe) {
        let result = store.saveSelectedVibe(vibe)
        
        switch result {
        case .duplicate:
            showDuplicateToast = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.showDuplicateToast = false
            }
            return
        case .newSelection:
            selectedVibe = vibe
            picksThisWeek = store.picksThisWeek()
            
            WidgetCenter.shared.reloadTimelines(ofKind: "VibeWidget")
            
            if picksThisWeek % 7 == 0 {
                lastPickWasMilestone = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                    self?.lastPickWasMilestone = false
                }
            }
        case .failed:
            return
        }
    }
    
    func refreshVibeState() {
        self.selectedVibe = store.loadSelectedVibe()
        self.picksThisWeek = store.picksThisWeek()
    }
}
