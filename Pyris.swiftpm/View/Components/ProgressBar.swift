//
//  ProgressBar.swift
//  calcifer
//
//  Created by Federica Mosca on 01/02/25.
//
import SwiftUI

struct ProgressBar: View {
    
    var progress: CGFloat
    
    var body: some View {
        
        GeometryReader { geometry in
       
            ZStack(alignment: .leading) {
        
                Capsule()
                    .frame(width: geometry.size.width, height: 25)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Capsule()
                    .frame(width: geometry.size.width * progress, height: 25)
                    .foregroundColor(.accentColor)
                    .animation(.easeInOut, value: progress)
            }
            .cornerRadius(5)
        }
        .frame(height: 25)
        .padding(.bottom)
    }
}
