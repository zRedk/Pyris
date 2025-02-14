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
        
        ZStack(alignment: .center) {
            
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 120) {
                
                Text("Pyris")
                    .font(.system(size: 72))
                    .fontWidth(.expanded)
                    .foregroundStyle(.white)
                
                Button("Start the experience", systemImage: "play") {
                    setSceneMode(.intro)
                }
                .font(.title2)
                .fontWeight(.bold)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
