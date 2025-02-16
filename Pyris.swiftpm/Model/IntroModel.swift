//
//  IntroModel.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

@MainActor
final class IntroModel: ObservableObject {
    
    @Published var showScene: Bool = false
    
    @Published var currentPhase: IntroPhase = .phase1
    
    @Published var nextButtonIsEnabled: Bool = false
    
    @Published var flowersToTap: Int = 4
    
    @Published var windIsBlowing: Bool = false
    
    func enableNext(_ phase: IntroPhase) {
        Task(priority: .userInitiated) { @MainActor in
            try? await Task.sleep(
                for: .seconds(phase == .phase3 ? 6 : 2)
            )
            withAnimation { nextButtonIsEnabled = true }
        }
    }
    
    func transition(to phase: IntroPhase) {
        withAnimation {
            nextButtonIsEnabled = false
            currentPhase = phase
        }
        if phase == .phase3 { showScene = true }
        enableNext(phase)
    }
}
