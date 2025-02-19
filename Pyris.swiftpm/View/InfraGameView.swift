//
//  InfraGameView.swift
//  Pyris
//
//  Created by Federica Mosca on 18/02/25.
//

import SwiftUI

struct InfraGameView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    @Environment(\.setSceneMode) private var setSceneMode
        
    private let titles: [String] = ["breathe out",
                                    "well done",
                                    "almost there"]
    
    private let bodies: [String] = ["gently into the microphone",
                                    "Pyris starts to become smaller, keep going!",
                                    "You can do it, once more!"]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.black
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text(titles[viewModel.currentSession - 1])
                        .font(.system(size: 48, weight: .bold))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    Group {
                        
                        if viewModel.currentSession == 1 {
                            
                            Text("blow ")
                                .foregroundColor(.orange) +
                            
                            Text(bodies[viewModel.currentSession - 1])
                            
                        } else {
                            
                            Text(bodies[viewModel.currentSession - 1])
                        }
                    }
                    .font(.system(size: 32))
                    .fontWidth(.expanded)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    
                    Spacer()
                }
                
                CustomButton(buttonType: .next) {
                    if viewModel.currentSession == 1 {
                        viewModel.currentSessionIsInteractive.toggle()
                    }
                    
                    setSceneMode(.game)
                }
                .padding(64)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .bottomTrailing)
            }
        }
        .onAppear {
            viewModel.gameViewIsShown = false
            
            if viewModel.currentSession != 1 {
                viewModel.currentSessionIsInteractive.toggle()
            }
        }
    }
}
