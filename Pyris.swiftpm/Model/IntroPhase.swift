//
//  IntroPhase.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import Foundation

enum IntroPhase: Int, CaseIterable, Hashable {
    
    case phase1 = 1
    case phase2 = 2
    case phase3 = 3
    case phase4 = 4
    case phase5 = 5
    case phase6 = 6
    case phase7 = 7
    
    var text: String {
        switch self {
        case .phase1: "In the vast darkness, a tiny light appears"
        case .phase2: "It's Pyris, glowing with joy"
        case .phase3: "Bringing light to everything around her"
        case .phase4: "So bright that awakes all the beauties of the woods"
        case .phase5: "But suddenly... the wind starts blowing"
        case .phase6: "Pyris fears the wind, starting to lose control"
        case .phase7: "The flames rage and endanger the forest"
        }
    }
    
    var next: Self? {
        switch self {
        case .phase1: .phase2
        case .phase2: .phase3
        case .phase3: .phase4
        case .phase4: .phase5
        case .phase5: .phase6
        case .phase6: .phase7
        default: nil
        }
    }
    
    var pyrisAssetName: String? {
        switch self {
        case .phase1: nil
        case .phase2: "Pyris"
        case .phase3: "Pyris"
        case .phase4: "Pyris"
        case .phase5: "PyrisFear"
        case .phase6: "PyrisFear"
        case .phase7: "PyrisFear"
        }
    }
    
    var pyrisAssetSize: CGFloat? {
        switch self {
        case .phase1: nil
        case .phase2: 1
        case .phase3: 1
        case .phase4: 1
        case .phase5: 1
        case .phase6: 1.3
        case .phase7: 2.5
        }
    }
}
