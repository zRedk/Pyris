//
//  SceneMode.swift
//  calcifer
//
//  Created by Federica Mosca on 08/02/25.
//

import SwiftUI

enum SceneMode: Equatable {
    
    struct Key: EnvironmentKey{
        nonisolated(unsafe) static let defaultValue: (SceneMode) -> Void = { _ in }
    }
    
    case launch
    case intro
    case game
    case endGame
}

extension EnvironmentValues {
    var setSceneMode: SceneMode.Key.Value {
        get { self[SceneMode.Key.self] }
        set { self[SceneMode.Key.self] = newValue }
    }
}
