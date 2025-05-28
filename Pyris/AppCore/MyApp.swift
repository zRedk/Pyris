//
//  MyApp.swift
//  Pyris
//
//  Created by Federica Mosca on 29/01/25.
//

import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var viewModel = AppModel()
    
    @State private var currentSceneMode: SceneMode = .launch
    
    @State private var audioService: AudioService = .init()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                
                Color.black
                
                switch currentSceneMode{
                case .launch: LauchView()
                case .micSetup: MicSetupView()
                case .intro: IntroView()
                case .tutorial: TutorialView()
                case .infraGame: InfraGameView()
                case .game: GameView()
                case .endGame: EndGameView()
                }
            }
            .ignoresSafeArea()
            .statusBarHidden(true)
            .environment(\.setSceneMode, setSceneMode)
            .environmentObject(viewModel)
            .onChange(of: scenePhase) { newValue in
                if newValue == .active {
                    audioService.playSoundEffect(nil, resume: true)
                } else {
                    audioService.stopPlaying(pause: true)
                }
            }
            .onAppear {
                guard let soundEffect = SoundEffect(fileNamed: "pyrisTheme", reapeatCount: -1) else { return }
                audioService.playSoundEffect(soundEffect)
            }
        }
    }
    
    private func setSceneMode(_ mode: SceneMode) {
        
        if mode == .launch {
            viewModel.reset()
        }
        
        switch mode {
        case .endGame:
            
            if let soundEffect = SoundEffect(fileNamed: "pyrisTheme", reapeatCount: -1){
                audioService.playSoundEffect(soundEffect)
            }
            
        case .launch:
            break
        default:
            audioService.stopPlaying()
        }
        
        currentSceneMode = mode
    }
}
