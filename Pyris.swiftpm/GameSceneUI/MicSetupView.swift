//
//  MicSetupView.swift
//  Pyris
//
//  Created by Federica Mosca on 20/02/25.
//

import SwiftUI

struct MicSetupView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @StateObject private var setupModel: MicSetupModel = .init()
    
    @State private var currentError: Error? = nil
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.black
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("microphone setup")
                        .font(.system(size: 48, weight: .bold))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    Group {
                        Text("Pyris requires the usage of microphone.")
                        
                        Text("Using the slider below")
                            .foregroundStyle(.orange)
                        
                        Text("adjust the sensibility according to your sorroundings.")
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 32))
                    .fontWidth(.expanded)
                    .padding(.horizontal, 64)
                    
                    Spacer()
                        .frame(maxHeight:100)
                             
                    HStack {
                        
                        VStack(alignment: .center) {
                            Slider(value: $setupModel.microphoneThreshold, in: -60 ... -15)
                                .frame(width: 400)
                            
                            ProgressBar(progress: setupModel.microphoneBarLevel, color: .green.opacity(0.7))
                                .tint(.green.opacity(0.5))
                                .frame(width: 400, height: 50)
                                .animation(.default, value: setupModel.microphoneBarLevel)
                        }
                        
                        VStack(alignment: .center) {
                            Text("Environment")
                                .font(.system(size: 28))
                                .foregroundStyle(.orange)
                            
                            Text(setupModel.microphoneText)
                                .font(.system(size: 32))
                        }
                        .frame(width: 200)
                        .foregroundStyle(.white)
                        .fontWidth(.expanded)
                        .padding(.horizontal, 64)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                CustomButton(buttonType: .next) {
                    
                    setupModel.dismantleActivity()
                    viewModel.activityUpdateThreshold = setupModel.microphoneThreshold
                    
                    withAnimation {
                        setSceneMode(.intro)
                    }
                }
                .padding(64)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .bottomTrailing)
            }
            .task(priority: .userInitiated) { @MainActor in
                do {
                    try await setupModel.startActivity()
                } catch { currentError = error }
            }
            .alert("Error", isPresented: .constant(currentError != nil)) {
                Button("I Understand.") { setSceneMode(.launch) }
            } message: { Text(currentError?.localizedDescription ?? "") }
        }
    }
}
