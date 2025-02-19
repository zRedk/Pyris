//
//  IntroView.swift
//  Pyris
//
//  Created by Federica Mosca on 08/02/25.
//
import SwiftUI

struct IntroView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @StateObject private var viewModel: IntroModel = .init()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .bottom) {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                    .overlay {
                        Color.black
                            .opacity(viewModel.showScene ? 0 : 1)
                            .animation(.easeInOut(duration: 6), value: viewModel.showScene)
                    }
                    .overlay {
                        LinearGradient(
                            colors: [.init("FireColor"), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity(viewModel.currentPhase == .phase7 ? 0.5 : 0)
                        .animation(.easeInOut, value: viewModel.currentPhase)
                    }
                
                VStack(alignment: .center) {
                    
                    Spacer()
                        .frame(maxHeight:100)
                    
                    Text(viewModel.currentPhase.text)
                        .id(viewModel.currentPhase)
                        .font(.system(size: 48))
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .shadow(color: .accentColor, radius: viewModel.showScene ? 10 : 5)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .transition(.opacity.animation(.easeInOut(duration: 1)))
                    
                    Spacer()
                    
                    if let assetName = viewModel.currentPhase.pyrisAssetName,
                       let assetSize = viewModel.currentPhase.pyrisAssetSize {
                        
                        let animation: Animation = viewModel.currentPhase == .phase7 ?
                            .easeInOut(duration: 3):
                            .easeInOut(duration: 3).repeatForever(autoreverses: true)
                        
                        Image(assetName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, alignment: .bottom)
                            .shadow(color: .accentColor, radius: 10)
                            .scaleEffect(assetSize, anchor: .bottom)
                            .transition(.scale.animation(.easeInOut(duration: 2)))
                            .animation(animation, value: assetSize)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                        .padding(.vertical, 32)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                
                if viewModel.currentPhase == .phase5 {
                    
                    WindAnimationView()
                        .offset(y: 150)
                        .onAppear {
                            withAnimation {
                                viewModel.windIsBlowing = true
                            }
                        }
                }
                
                if viewModel.currentPhase.rawValue >= IntroPhase.phase4.rawValue {
                    
                    FlowersTapGroup(
                        parentGeometry: geometry,
                        viewModel: viewModel
                    )
                }
                
                if viewModel.nextButtonIsEnabled &&
                    !(viewModel.currentPhase == .phase4
                      && viewModel.flowersToTap > 0) {
                    
                    CustomButton(buttonType: .next) {
                        if let nextPhase = viewModel.currentPhase.next {
                            viewModel.transition(to: nextPhase)
                        } else {
                            setSceneMode(.tutorial)
                        }
                    }
                    .id(viewModel.currentPhase)
                    .padding(64)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .bottomTrailing)
                    .transition(.opacity.animation(.easeInOut(duration: 2)))

                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
        }
        .onAppear { viewModel.enableNext(viewModel.currentPhase) }
    }
}
