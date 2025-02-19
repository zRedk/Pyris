//
//  FlowerColor.swift
//  Pyris
//
//  Created by Federica Mosca on 19/02/25.
//

import SwiftUI

enum FlowerColor {
    
    case lilac
    case white
    
    var assetName: String {
        switch self {
        case .lilac: "LilacDaisy"
        case .white: "WhiteDaisy"
        }
    }
    
    var shadowColor: Color {
        switch self {
        case .lilac: .purple
        case .white: .yellow
        }
    }
}
