//
//  TutorialPhase.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

import SwiftUI

enum TutorialPhase {
    case phase1
    case phase2
    
    var next: TutorialPhase? {
        switch self {
        case .phase1: .phase2
        default: nil
        }
    }
    
    var title: String {
        switch self {
        case .phase1: "help Pyris calm the storm!"
        case .phase2: "breathe in"
        }
    }
    
    @ViewBuilder var body: some View {
        
        switch self {
        case .phase1:
            
            VStack(alignment: .center, spacing: 10) {
                
                Text("When panic strikes, your heart races")
                
                Text("Just like Pyris is doing now")
                    .foregroundStyle(.orange)
                
                Text("Use your breath to help shrink Pyris and tame the tempest.")
            }
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            
        case .phase2:
            
            VStack(alignment: .center, spacing: 10) {
                    
               Text("Inhale ")
                   .foregroundColor(.orange) +
               
               Text("slowly though your nose")
                   .foregroundColor(.white)
                
                Text("and hold your breath")
                    .foregroundStyle(.white)
            }
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
        }
    }
}
