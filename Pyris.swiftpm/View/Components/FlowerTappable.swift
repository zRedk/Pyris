//
//  FlowerTappable.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

struct FlowerTappable: View {
    
    enum FlowerColor {
        
        case lilac
        case white
        
        var assetName: String {
            switch self {
            case .lilac: "LilacDaisy"
            case .white: "WhiteDaisy"
            }
        }
        
        var shadowColor: Color {
            switch self {
            case .lilac: .purple
            case .white: .yellow
            }
        }
    }
    
    let flowerColor: FlowerColor
    
    let isBurnt: Bool
    
    @State private var flowerIsShown: Bool = false
    
    @State private var isAnimating: Bool = false
    
    @Binding var flowersToTap: Int
    
    var body: some View {
        
        ZStack {
            
            if flowerIsShown {
                
                Image(flowerColor.assetName + (isBurnt ? "Burnt" : ""))
                    .resizable()
                    .scaledToFit()
                    .shadow(color: isBurnt ? .accentColor : flowerColor.shadowColor, radius: 5)
                    .frame(width: 70)
                    .offset(x: isBurnt ? -10:0)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5), value: isBurnt)
                
            } else {
                
                Circle()
                    .fill(.white.opacity(0.4))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .opacity(isAnimating ? 0.7 : 0.5)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                    .transition(.opacity)
                
                Button {
                    withAnimation {
                        flowerIsShown.toggle()
                        flowersToTap -= 1
                    }
                } label: {
                    Circle()
                        .fill(.white)
                        .frame(width: 80, height: 80)
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .opacity(isAnimating ? 0.7 : 0.5)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                        .transition(.opacity)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(width: 100)
        .onAppear { isAnimating = true }
    }
}

struct PulsatingButton: View {
    @State private var isPressed = false
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.5))
                .frame(width: 80, height: 80)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .opacity(isAnimating ? 0.7 : 0.5)
                .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
            
            Button(action: {
                withAnimation(.easeOut(duration: 0.2)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring()) {
                        isPressed = false
                    }
                }
            }) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    )
                    .scaleEffect(isPressed ? 0.85 : 1.0)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}
