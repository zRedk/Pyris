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
                        .opacity(0.5)
                    }
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text(currentPhase.title)
                        .font(.system(size: 48, weight: .bold))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    Text(currentPhase.body)
                        .font(.system(size: 32))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 64)
                    Spacer()
                }
                .padding(.horizontal)
                
                CustomButton(isLaunchButton: false) {
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
        }
    }
}
