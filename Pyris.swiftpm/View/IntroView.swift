//
//  IntroView.swift
//  calcifer
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
                    .overlay(
                        Color.black
                            .opacity(viewModel.showScene ? 0 : 1)
                            .animation(.easeInOut(duration: 6), value: viewModel.showScene)
                    )
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
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
                    
                    if viewModel.currentPhase != .phase1 {
                        
                        Image("Pyris")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .shadow(color: .accentColor, radius: 10)
                            .padding(.bottom, 70)
                            .transition(.scale.animation(.easeInOut(duration: 2)))
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                
                if viewModel.currentPhase == .phase5 {
                    
                    WindAnimationView()
                        .offset(y: 150)
                    
                } else if viewModel.currentPhase == .phase4 {
                    
                    FlowersGroup(
                        parentGeometry: geometry,
                        flowersToTap: $viewModel.flowersToTap
                    )
                }
                
                if viewModel.nextButtonIsEnabled &&
                    !(viewModel.currentPhase == .phase4
                      && viewModel.flowersToTap != 0) {
                    
                    Button("Next", systemImage: "arrowshape.forward") {
                        if let nextPhase = viewModel.currentPhase.next {
                            viewModel.transition(to: nextPhase)
                            
                        } else { setSceneMode(.game) }
                    }
                    .id(viewModel.currentPhase)
                    .font(.title2)
                    .fontWeight(.bold)
                    .buttonStyle(.borderedProminent)
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
