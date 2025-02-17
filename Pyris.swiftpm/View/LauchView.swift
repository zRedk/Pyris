//
//  LauchView.swift
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
                    
                    Button {
                        withAnimation {
                            setSceneMode(.intro)
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.accentColor.opacity(0.8))
                                .frame(width: 200, height: 80)
                                .shadow(radius: 8)
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.accentColor)
                                .frame(width: 180, height: 60)
                            
                            VStack {
                                Text("START")
                                    .fontWeight(.bold)
                                    .fontWidth(.expanded)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .transition(.opacity)
    }
}
