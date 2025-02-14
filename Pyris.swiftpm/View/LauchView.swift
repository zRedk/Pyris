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
        ZStack(alignment: .bottom) {
            Color.black
                .ignoresSafeArea()

            Image("calcifer")
                .resizable()
                .frame(width: 100, height: 100)
                .shadow(color: Color.orange, radius: 10)
                .padding(.bottom, 70)
            
            Button("Start") {
                setSceneMode(.intro)
            }
        }
    }
}
