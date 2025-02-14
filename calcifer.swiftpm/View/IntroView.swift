//
//  IntroView.swift
//  calcifer
//
//  Created by Federica Mosca on 08/02/25.
//
import SwiftUI

struct IntroView: View {
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    @State private var showScene: Bool = false
    @State private var currentPhraseIndex: Int = 0
    
    private let animationDuration: Double = 6.0
    private let phrases: [String] = [
            "In the vast darkness, a tiny light appears",
            "It's Pyris, glowing with joy",
            "bringing light to everything around her."
        ]

    
    var body: some View {
        
        ZStack(alignment: .bottom) {

            Image("background")
                .resizable()
                .scaledToFill()
                
                .overlay(
                    Color.black
                        .opacity(showScene ? 0 : 1)
                        .animation(.easeIn(duration: animationDuration), value: showScene)
                )
                .ignoresSafeArea()

            Image("calcifer")
                 .resizable()
                 .frame(width: 100, height: 100)
                 .shadow(color: Color.orange, radius: 10)
                 //.offset(y: 250)
                 .padding(.bottom, 70)
        }
        .task(priority: .userInitiated) { @MainActor in
            
            showScene = true
            
            try? await Task.sleep(for: .seconds(animationDuration))
            setSceneMode(.game)
        }
    }
}
