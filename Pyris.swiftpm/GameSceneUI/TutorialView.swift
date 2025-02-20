//
//  TutorialView.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @State private var currentPhase: TutorialPhase = .phase1
    
    @State private var audioService: AudioService = .init()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.black
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text(currentPhase.title)
                        .font(.system(size: 48, weight: .bold))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    currentPhase.body
                        .font(.system(size: 32))
                        .fontWidth(.expanded)
                        .padding(.horizontal, 64)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                CustomButton(buttonType: .next) {
                    withAnimation {
                        if let nextPhase = currentPhase.next {
                            currentPhase = nextPhase
                            
                        } else { setSceneMode(.game) }
                    }
                }
                .padding(64)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .bottomTrailing)
            }
            .onAppear {
                guard let soundEffect: SoundEffect = .init(
                    fileNamed: "singleHeartbeat",
                    reapeatCount: -1,
                    playbackRate: 1.5
                ) else { return }
                
                audioService.playSoundEffect(soundEffect)
            }
        }
    }
}
