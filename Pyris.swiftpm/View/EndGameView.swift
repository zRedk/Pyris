//
//  EndGameView.swift
//  Pyris
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
                
                VStack (alignment: .center) {
                    
                    Spacer()
                    
                    Text("Congratulations!")
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
                    
                    Text("You’ve helped Pyris find calm and clear the storm!")
                        .font(.system(size: 32))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: 10)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 64)
                    
                    Spacer()
                    
                    Image("Pyris")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, alignment: .bottom)
                        .shadow(color: .accentColor, radius: 10)
                        .scaleEffect(1, anchor: .bottom)
                        //.transition(.scale.animation(.easeInOut(duration: 2)))
                        //.animation(animation, value: 1)
                    
                    Spacer()
                        .frame(height: 50)
                        .padding(.vertical, 32)
                }
            }
            .transition(.opacity.animation(.easeInOut(duration: 1)))
            
        }
    }
}

