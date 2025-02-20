//
//  MicSetupModel.swift
//  Pyris
//
//  Created by Federica Mosca on 20/02/25.
//

import Foundation

import Combine

@MainActor
final class MicSetupModel: ObservableObject {
    
    private let audioService = AudioService()
    private var timer: DispatchSourceTimer?
    
    var microphoneText: String {
        if microphoneThreshold >= -20 { return "Very noisy" }
        else if microphoneThreshold > -30 { return "Noisy" }
        else if microphoneThreshold > -45 { return "Average" }
        else if microphoneThreshold > -50 { return "Quiet" }
        else { return "Very Quiet" }
    }
    
    @Published var microphoneBarLevel: CGFloat = 0
    
    @Published var microphoneThreshold: Float = -35
    
    private func startTimer() {
        stopTimer()
        
        let newTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        newTimer.schedule(deadline: .now(), repeating: 0.2)
        newTimer.setEventHandler { [weak self] in
            Task { @MainActor in
                self?.microphoneUpdate()
            }
        }
        newTimer.resume()
        timer = newTimer
    }
    
    private func microphoneUpdate() {
        guard let recorder = self.audioService.audioRecorder else {
            return
        }
        
        recorder.updateMeters()
        let currentLevel = recorder.averagePower(forChannel: 0)
        
        let gain: Float = 2
        let normalizedLevel = (currentLevel - microphoneThreshold) / (0 - microphoneThreshold)
        let adjustedLevel = min(normalizedLevel * gain, 1)
        
        self.microphoneBarLevel = min(max(.init(adjustedLevel), 0.1), 1.0)
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func startActivity() async throws {
        try await audioService.requestPermission()
        try audioService.setupRecording()
        
        startTimer()
    }
    
    func dismantleActivity() {
        stopTimer()
        audioService.stopRecording()
    }
}
