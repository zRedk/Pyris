//
//  TutorialPhase.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

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
        case .phase2: "breathe in, beathe out"
        }
    }
    
    var body: String {
        switch self {
        case .phase1: "When panic strikes, your heart races—just like Pyris’s does now. Use your breath to help shrink Pyris and tame the tempest."
        case .phase2: "Inhale slowly through your nose, hold your breath counting to four, blow gently into the microphone."
        }
    }
}
