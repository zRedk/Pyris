//
//  AppModel.swift
//  Pyris
//
//  Created by Federica Mosca on 29/01/25.
//

import SwiftUI

@MainActor
final class AppModel: ObservableObject {
    
    private let audioService = AudioService()
    let requiredBlowingTime: TimeInterval = 3.0
    let maxSessions = 3
    let maxInactiveTime: TimeInterval = 4.0
    
    private var timer: DispatchSourceTimer?
    private var lastUpdateTime: Date?
    
    var activityUpdateThreshold: Float = -35
    
    @Published var blowingTime: TimeInterval = 0.0
    @Published var activityLevel: CGFloat = 0.0
    @Published var currentSession: Int = 1
    @Published var currentSessionIsInteractive: Bool = false
    @Published var gameCompleted: Bool = false
    @Published var inactiveTime: TimeInterval = 0.0
    @Published var isFirstInfraGameShown: Bool = false
    
    @Published var gameViewIsShown: Bool = true {
        didSet {
            guard let soundEffect: SoundEffect = .init(
                fileNamed: "inhale"
            ) else { return }
            
            if gameViewIsShown && !currentSessionIsInteractive {
                audioService.playSoundEffect(soundEffect)
                
            } else { audioService.stopPlaying() }
        }
    }
    
    func reset() {
        audioService.stopRecording()
        timer?.cancel()
        timer = nil
        blowingTime = 0.0
        activityLevel = 0.0
        currentSession = 1
        currentSessionIsInteractive = false
        gameCompleted = false
        inactiveTime = 0.0
        gameViewIsShown = false
        isFirstInfraGameShown = false
    }
    
    private func startTimer() {
        stopTimer()
        
        let newTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        newTimer.schedule(deadline: .now(), repeating: 0.1)
        newTimer.setEventHandler { [weak self] in
            Task { @MainActor in
                self?.updateActivityLevel()
            }
        }
        newTimer.resume()
        timer = newTimer
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func updateActivityLevel() {
        
        guard let recorder = audioService.audioRecorder,
              currentSessionIsInteractive,
              gameViewIsShown else {
            lastUpdateTime = Date()
            blowingTime = 0.0
            return
        }
        
        recorder.updateMeters()
        let level = recorder.averagePower(forChannel: 0)
        
        let currentTime = Date()
        
        if level > activityUpdateThreshold {
            
            if let lastTime = lastUpdateTime {
                let deltaTime = currentTime.timeIntervalSince(lastTime)
                blowingTime += deltaTime
            }
                        
            if blowingTime >= requiredBlowingTime {
                sessionSuccess()
            }
            
        } else { blowingTime = 0.0 }
        
        lastUpdateTime = currentTime
    }
    
    private func sessionSuccess() {
        if currentSession < maxSessions {
            print("Session \(currentSession) completed!")
            activityLevel -= 0.3
            currentSession += 1
            blowingTime = 0.0
        } else {
            print("All sessions completed!")
            stopTimer()
            gameCompleted = true
        }
    }

    
    func startActivity() async throws {
        
        try await audioService.requestPermission()
        try audioService.setupRecording()
        
        currentSession = 1
        activityLevel = 1
        blowingTime = 0.0
        lastUpdateTime = nil
        
        startTimer()
    }
}
