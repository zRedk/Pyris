//
//  ProgressBar.swift
//  Pyris
//
//  Created by Federica Mosca on 01/02/25.
//

import SwiftUI

struct ProgressBar: View {
    
    private var progress: CGFloat
    
    private let color: Color
    
    var body: some View {
        
        GeometryReader { geometry in
       
            ZStack(alignment: .leading) {
        
                Capsule()
                    .frame(width: geometry.size.width, height: 25)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Capsule()
                    .frame(width: geometry.size.width * progress, height: 25)
                    .foregroundColor(color)
            }
            .cornerRadius(5)
        }
        .frame(height: 25)
    }
    
    init(progress: CGFloat, color: Color = .accentColor) {
        self.progress = progress
        self.color = color
    }
}
