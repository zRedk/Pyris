//
//  AudioService.swift
//  calcifer
//
//  Created by Federica Mosca on 29/01/25.
//

import AVFoundation

final class AudioService: Sendable {
    
    private let audioSession: AVAudioSession = .sharedInstance()
    
    @MainActor var audioRecorder: AVAudioRecorder?
    
    func requestPermission() async -> Bool {
        
        await withCheckedContinuation { continuation in
            
            audioSession.requestRecordPermission {
                continuation.resume(returning: $0)
            }
        }
    }
    
    func setupRecording() async throws {
                
        try audioSession.setCategory(
            .playAndRecord,
            mode: .measurement,
            options: .defaultToSpeaker
        )
        
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let url = URL(fileURLWithPath: "/dev/null")
       
        let audioRecorder = try AVAudioRecorder(url: url, settings: [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ])
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        await MainActor.run { self.audioRecorder = audioRecorder }
    }
}
