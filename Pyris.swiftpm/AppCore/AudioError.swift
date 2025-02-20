//
//  AudioError.swift
//  Pyris
//
//  Created by Federica Mosca on 20/02/25.
//

import Foundation

enum AudioError: LocalizedError {
    
    case permissionDenied
    
    var errorDescription: String? {
        switch self {
        case .permissionDenied: "Permission to record audio has not been granted. Please go to Settings > Privacy > Microphone to allow this app to record audio."
        }
    }
}
