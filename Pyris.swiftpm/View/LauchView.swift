//
//  LauchView.swift
//  calcifer
//
//  Created by Federica Mosca on 08/02/25.
//

import SwiftUI

struct LauchView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                
                VStack(spacing: 120) {
                    
                    Text("Pyris")
                        .font(.system(size: 72))
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button("Start the experience", systemImage: "play") {
                        withAnimation {
                            setSceneMode(.intro)
                        }
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .buttonStyle(.borderedProminent)
                    .scaleEffect(1.5)
                }
            }
        }
        .transition(.opacity)
    }
}
