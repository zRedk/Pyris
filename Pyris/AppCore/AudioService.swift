//
//  AudioService.swift
//  Pyris
//
//  Created by Federica Mosca on 29/01/25.
//

import AVFoundation

@MainActor
final class AudioService {
        
    private var audioPlayer: AVAudioPlayer?
    
    var audioRecorder: AVAudioRecorder?
    
    func requestPermission() async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            AVAudioSession.sharedInstance().requestRecordPermission {
                $0 ? continuation.resume() :
                     continuation.resume(
                        throwing: AudioError.permissionDenied
                     )
            }
        }
    }
    
    func playSoundEffect(_ soundEffect: SoundEffect?, resume: Bool = false) {
        
        if resume {
            audioPlayer?.play()
            
        } else if let soundEffect {
            audioPlayer = try? .init(contentsOf: soundEffect.fileURL)
            audioPlayer?.numberOfLoops = soundEffect.repeatCount
            audioPlayer?.enableRate = true
            audioPlayer?.rate = soundEffect.playbackRate
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
    }
    
    func setupRecording() throws {
                
        try AVAudioSession.sharedInstance().setCategory(
            .playAndRecord,
            mode: .measurement,
            options: .defaultToSpeaker
        )
        
        try AVAudioSession.sharedInstance().setActive(
            true,
            options: .notifyOthersOnDeactivation
        )
        
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
        
        self.audioRecorder = audioRecorder
    }
    
    func stopPlaying(pause: Bool = false) {
        
        if pause {
            audioPlayer?.pause()
        } else {
            audioPlayer?.stop()
            audioPlayer = nil
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
}
