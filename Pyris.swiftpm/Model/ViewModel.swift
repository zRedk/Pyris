//
//  ViewModel.swift
//  Pyris
//
//  Created by Federica Mosca on 29/01/25.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    private let audioService = AudioService()
    private let activityUpdateThreshold: Float = -35
    let requiredBlowingTime: TimeInterval = 3.0
    let maxSessions = 3
    let maxInactiveTime: TimeInterval = 4.0
    
    private var timer: DispatchSourceTimer?
    private var lastUpdateTime: Date?
    
    @Published var blowingTime: TimeInterval = 0.0
    @Published var activityLevel: CGFloat = 0.0
    @Published var currentSession: Int = 1
    @Published var currentSessionIsInteractive: Bool = false
    @Published var gameCompleted: Bool = false
    @Published var inactiveTime: TimeInterval = 0.0
    @Published var gameViewIsShown: Bool = true
    @Published var isFirstInfraGameShown: Bool = false
    
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

    
    func startActivity() async {
        guard await audioService.requestPermission() else {
            print("Could not acquire permission to start recording")
            return
        }
        
        do {
            try await audioService.setupRecording()
        } catch {
            print("Could not start Audio monitoring: \(error)")
            return
        }
        
        currentSession = 1
        activityLevel = 1
        blowingTime = 0.0
        lastUpdateTime = nil
        
        startTimer()
    }
}
