//
//  GameView.swift
//  Pyris
//
//  Created by Federica Mosca on 29/01/25.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @State private var progress: CGFloat = 0
    
    @State private var currentError: Error?
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                    .overlay {
                        LinearGradient(
                            colors: [.init("FireColor"), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity({
                            switch viewModel.currentSession {
                            case 1: 0.8
                            case 2: 0.6
                            case 3: 0.3
                            default: 0
                            }
                        }())
                    }
                    .animation(.easeInOut, value: viewModel.currentSession)
                
                VStack {
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    Text(viewModel.currentSessionIsInteractive ? "Blow" : "Inhale")
                        .font(.system(size: 48))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                    
                    Image("PyrisFear")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .accentColor, radius: 10)
                        .frame(width: 150)
                        .scaleEffect(2.5 * viewModel.activityLevel, anchor: .bottom)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.activityLevel)
                    
                    ProgressBar(progress: progress)
                        .frame(width: 600, height: 50)
                        .padding(.vertical, 32)
                }
                .onAppear {
                    if viewModel.currentSession == 1 &&
                       viewModel.currentSessionIsInteractive {
                        progress = 1.0
                    }
                }
                .onChange(of: viewModel.currentSession) { _ in
                    setSceneMode(.infraGame)
                }
                .onChange(of: viewModel.blowingTime) { newValue in
                    if viewModel.currentSessionIsInteractive {
                        withAnimation(.easeInOut) {
                            progress = 1.0 - min(CGFloat(viewModel.blowingTime / viewModel.requiredBlowingTime), 1.0)
                        }
                    }
                }
                .onChange(of: viewModel.gameCompleted) { isCompleted in
                    if isCompleted { setSceneMode(.endGame) }
                }
                
            }
            .task(priority: .userInitiated) { @MainActor in
                
                if viewModel.currentSession == 1 &&
                   !viewModel.currentSessionIsInteractive &&
                   !viewModel.isFirstInfraGameShown {
                    
                    do { try await viewModel.startActivity() }
                    catch { currentError = error; return }
                }
                
                viewModel.isFirstInfraGameShown = false
                viewModel.gameViewIsShown = true
                
                if !viewModel.currentSessionIsInteractive {
                    
                    withAnimation(.easeInOut(duration: 5.0)) {
                        progress = 1.0
                    }
                    
                    try? await Task.sleep(for: .seconds(5))
                    
                    if viewModel.currentSession == 1 {
                        viewModel.isFirstInfraGameShown = true
                        setSceneMode(.infraGame)
                    } else {
                        viewModel.currentSessionIsInteractive = true
                    }
                }
            }
            .alert("Error", isPresented: .constant(currentError != nil)) {
                Button("I Understand.") { setSceneMode(.launch) }
            } message: { Text(currentError?.localizedDescription ?? "") }
        }
    }
}
