//
//  CustomButton.swift
//  Pyris
//
//  Created by Federica Mosca on 17/02/25.
//

import SwiftUI

struct CustomButton: View {
    
    let buttonType: ButtonType
    
    let action: @MainActor () -> Void
    
    var body: some View {
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.accentColor.opacity(0.8))
                    .frame(width: buttonType.outerSize.width,
                           height: buttonType.outerSize.height)
                    .shadow(radius: 8)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.accentColor)
                    .frame(width: buttonType.innerSize.width,
                           height: buttonType.innerSize.height)
                
                HStack(spacing: 10) {
                    
                    Text(buttonType.text)
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
