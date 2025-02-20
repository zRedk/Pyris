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
    
    @State private var microphoneThreshold: Float = -35
    
    private var microphoneText: String {
        if microphoneThreshold >= -20 { return "Very noisy" }
        else if microphoneThreshold > -30 { return "Noisy" }
        else if microphoneThreshold > -45 { return "Average" }
        else if microphoneThreshold > -50 { return "Quiet" }
        else { return "Very Quiet" }
    }
    
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
                        
                        Text("you can adjust the volume if you are in a noisy environment.")
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 32))
                    .fontWidth(.expanded)
                    .padding(.horizontal, 64)
                    
                    Spacer()
                        .frame(maxHeight:100)
                             
                    HStack {
                        
                        Slider(value: $microphoneThreshold, in: -60 ... -15)
                            .frame(width: 400, height: 50)
                        
                        VStack(alignment: .center) {
                            Text("Environment")
                                .font(.system(size: 28))
                                .foregroundStyle(.orange)
                            
                            Text(microphoneText)
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
                    
                    viewModel.activityUpdateThreshold = microphoneThreshold
                    
                    withAnimation {
                        setSceneMode(.intro)
                    }
                }
                .padding(64)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .bottomTrailing)
            }
        }
    }
}
