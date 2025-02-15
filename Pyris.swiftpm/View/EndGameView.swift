//
//  EndGameView.swift
//  calcifer
//
//  Created by Federica Mosca on 01/02/25.
//

import SwiftUI

struct EndGameView: View {
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                
                VStack {
                    Text("You blowed all the wind out!")
                        .font(.system(size: 48))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .transition(.opacity.animation(.easeInOut(duration: 1)))
            
        }
    }
}

