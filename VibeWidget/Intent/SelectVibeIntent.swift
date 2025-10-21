//
//  SelectVibeIntent.swift
//  VibeWidgetExtension
//
//  Created by Aviran Dabush on 21/10/2025.
//

import AppIntents
import WidgetKit
import Foundation

struct SelectVibeIntent: AppIntent {
    static var title: LocalizedStringResource = "Select Vibe"
    static var description = IntentDescription("Selects a new Vibe and updates the widget.")
    
    @Parameter(title: "The selected vibe")
    var selectedVibe: Vibe
    
    // Required by App Intents; must initialize all @Parameter variables with a default Vibe for serialization and internal setup.
    init() {
        self.selectedVibe = .joy
    }
    
    init(vibe: Vibe) {
        self.init()
        self.selectedVibe = vibe
    }
    
    func perform() async throws -> some IntentResult {
        let store = VibeStore.shared
        _ = store.saveSelectedVibe(selectedVibe)
        
        WidgetCenter.shared.reloadTimelines(ofKind: "VibeWidget")
        return .result()
    }
}
