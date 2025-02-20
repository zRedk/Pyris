//
//  LaunchView.swift
//  Pyris
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
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500)
                        .shadow(color: .black, radius: 10)
                    
                    CustomButton(buttonType: .start) {
                        withAnimation {
                            setSceneMode(.micSetup)
                        }
                    }
                }
            }
        }
        .transition(.opacity)
    }
}
