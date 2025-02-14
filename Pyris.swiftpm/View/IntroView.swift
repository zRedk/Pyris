//
//  IntroView.swift
//  calcifer
//
//  Created by Federica Mosca on 08/02/25.
//
import SwiftUI

struct IntroView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @State private var showScene: Bool = false
    
    @State private var currentPhase: Phase = .phase1
    
    @State private var nextButtonIsEnabled: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .overlay(
                        Color.black
                            .opacity(showScene ? 0 : 1)
                            .animation(.easeInOut(duration: 6), value: showScene)
                    )
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text(currentPhase.text)
                        .id(currentPhase)
                        .font(.system(size: 48))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: showScene ? 10 : 5)
                        .transition(.opacity.animation(.easeInOut(duration: 1)))
                    
                    Spacer()
                    
                    if currentPhase != .phase1 {
                        
                        Image("Pyris")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .shadow(color: .orange, radius: 10)
                            .padding(.bottom, 70)
                            .transition(.scale.animation(.easeInOut(duration: 2)))
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                
                if nextButtonIsEnabled {
                    
                    Button("Next", systemImage: "arrowshape.forward") {
                        if let nextPhase = currentPhase.next {
                            transition(to: nextPhase)
                            
                        } else { setSceneMode(.game) }
                    }
                    .id(currentPhase)
                    .font(.title2)
                    .fontWeight(.bold)
                    .buttonStyle(.borderedProminent)
                    .padding(64)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .bottomTrailing)
                    .transition(.opacity.animation(.easeInOut(duration: 2)))
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
        }
        .onAppear { enableNext(currentPhase) }
    }
    
    private func enableNext(_ phase: Phase) {
        
        Task(priority: .userInitiated) { @MainActor in
            
            try? await Task.sleep(for: .seconds(phase == .phase3 ? 6 : 2))
            withAnimation { nextButtonIsEnabled = true }
        }
    }
    
    private func transition(to phase: Phase) {
        
        withAnimation {
            nextButtonIsEnabled = false
            currentPhase = phase
        }
        if phase == .phase3 { showScene = true }
        enableNext(phase)
    }
}

// MARK: - Supporting types

extension IntroView {
    
    private enum Phase: Int, CaseIterable, Hashable {
        
        case phase1 = 1
        case phase2 = 2
        case phase3 = 3
        case phase4 = 4
        case phase5 = 5
        case phase6 = 6
        case phase7 = 7
         
        var text: String {
            switch self {
            case .phase1: "In the vast darkness, a tiny light appears"
            case .phase2: "It's Pyris, glowing with joy"
            case .phase3: "Bringing light to everything around her"
            case .phase4: "Dancing and waking up all the flowers"
            case .phase5: "Suddenly the wind starts hitting Pyris"
            case .phase6: "Pyris starts growing out of control"
            case .phase7: "The flames rage and endanger the forest"
            }
        }
        
        var next: Phase? {
            switch self {
            case .phase1: .phase2
            case .phase2: .phase3
            case .phase3: .phase4
            case .phase4: .phase5
            case .phase5: .phase6
            case .phase6: .phase7
            default: nil
            }
        }
    }
}
