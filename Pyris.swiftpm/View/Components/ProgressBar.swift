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
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geo.size.width, height: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: geo.size.width * progress, height: 10)
                    .foregroundColor(.accentColor)
                    .animation(.easeInOut, value: progress)
            }
            .cornerRadius(5)
        }
        .frame(height: 25)
    }
}
