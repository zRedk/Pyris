//
//  EndGameView.swift
//  Pyris
//
//  Created by Federica Mosca on 01/02/25.
//

import SwiftUI

struct EndGameView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @State private var currentPhase: Int = 1
    
    @State private var revealProgress: CGFloat = 0
    
    private let titles: [String?] = ["congratulations!",
                                    nil,
                                    nil,
                                    nil]
    
    private let bodies: [String?] = ["you've helped Pyris to find calm and clear the storm",
                                    nil,
                                    "keep believing in your strength\npeace and hope can follow even the darkest moments.",
                                    "you can always begin again, stronger than before!"]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .bottom) {
                
                if currentPhase != 4 {
                    Group {
                        Image("Background")
                            .resizable()
                            .scaledToFill()
                        if currentPhase >= 2 {
                            Image("Rainbow")
                                .resizable()
                                .scaledToFill()
                                
                                .mask {
                                    Circle()
                                        .trim(from: 0, to: revealProgress)
                                        .rotationEffect(.degrees(90))
                                        .scaleEffect(1.5)
                                }
                        }
                        Image("WoodsNoBG")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                } else { Color.black }
                
                VStack (alignment: .center) {
                    
                    if let title = titles[currentPhase - 1] {
                        Spacer()
                            .frame(height: 100)
                        
                        Text(title)
                            .font(.system(size: 48, weight: .bold))
                            .fontWidth(.expanded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .shadow(color: .accentColor, radius: 10)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .transition(.opacity.animation(.easeInOut(duration: 2)))
                    }
                    
                    if let text = bodies[currentPhase - 1] {
                        Spacer()
                            .frame(height: 200)
                        
                        Text(text)
                            .font(.system(size: 32))
                            .fontWidth(.expanded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .transition(.opacity.animation(.easeInOut(duration: 2)))
                    }
                    
                    Spacer()
                    
                    Image("Pyris")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, alignment: .bottom)
                        .shadow(color: .accentColor, radius: 10)
                        .scaleEffect(1, anchor: .bottom)
                        .transition(.opacity.animation(.easeInOut(duration: 2)))
                    
                    Spacer()
                        .frame(height: 50)
                        .padding(.vertical, 32)
                }
                
                if currentPhase > 1 && currentPhase < 4 {
                    FlowersGroup(parentGeometry: geometry)
                }
                
                if currentPhase != 2 {
                    
                    CustomButton(buttonType: currentPhase == 4 ? .restart : .next) {
                        
                        if currentPhase == 4 {
                            setSceneMode(.launch); return
                        }
                        
                        Task(priority: .userInitiated) { @MainActor in
                            withAnimation(.easeInOut(duration: 1)) {
                                currentPhase += 1
                            }
                            if currentPhase == 2 {
                                withAnimation(.easeInOut(duration: 4)) {
                                    revealProgress = 1
                                }
                                try? await Task.sleep(for: .seconds(4))
                                currentPhase += 1
                            }
                        }
                    }
                    .padding(64)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .bottomTrailing)
                    .transition(.opacity.animation(.easeInOut(duration: 2)))
                }
            }
            .transition(.opacity.animation(.easeInOut(duration: 1)))
        }
    }
}
