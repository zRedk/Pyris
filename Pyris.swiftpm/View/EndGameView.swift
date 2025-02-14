//
//  EndGameView.swift
//  calcifer
//
//  Created by Federica Mosca on 01/02/25.
//

import SwiftUI

struct EndGameView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Text("You blowed all the wind out!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

