//
//  CustomButton.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

import SwiftUI

struct CustomButton: View {
    
    let isLaunchButton: Bool
    
    let action: @MainActor () -> Void
    
    var body: some View {
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.accentColor.opacity(0.8))
                    .frame(width: isLaunchButton ? 200:150,
                           height: isLaunchButton ? 80:60)
                    .shadow(radius: 8)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor)
                    .frame(width: isLaunchButton ? 180:130,
                           height: isLaunchButton ? 60:40)
                
                HStack(spacing: 10) {
                    
                    Text(isLaunchButton ? "START":"Next")
                        .font(.title2)
                        .fontWidth(.expanded)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
