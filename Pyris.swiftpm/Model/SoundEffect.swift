//
//  SoundEffect.swift
//  Pyris
//
//  Created by Federica Mosca on 20/02/25.
//

import Foundation

struct SoundEffect: Sendable {
    
    let fileURL: URL
    let repeatCount: Int
    let playbackRate: Float
    
    init?(
        fileNamed: String,
        reapeatCount: Int = 0,
        playbackRate: Float = 1.0
    ) {
        let audioFile = Bundle.main.url(
            forResource: fileNamed,
            withExtension: "mp3"
        )
        guard let audioFile else {
            return nil
        }
        self.fileURL = audioFile
        self.repeatCount = reapeatCount
        self.playbackRate = playbackRate
    }
}
