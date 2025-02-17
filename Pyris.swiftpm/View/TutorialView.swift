//
//  TutorialView.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

import SwiftUI

struct TutorialView: View {
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                    .overlay {
                        LinearGradient(
                            colors: [.init("FireColor"), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                
                
                VStack {
                    
                    
                    
                }
            }
        }
    }
}
