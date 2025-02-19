//
//  ButtonType.swift
//  Pyris
//
//  Created by Federica Mosca on 19/02/25.
//

import SwiftUI

enum ButtonType {
    
    case start
    case next
    case restart
    
    var text: String {
        switch self {
        case .start: "START"
        case .next: "next"
        case .restart: "RESTART"
        }
    }
    
    var innerSize: CGSize {
        switch self {
        case .start: .init(width: 180, height: 60)
        default: .init(width: 130, height: 40)
        }
    }
    
    var outerSize: CGSize {
        switch self {
        case .start: .init(width: 200, height: 80)
        default: .init(width: 150, height: 60)
        }
    }
}
