//
//  FlowersGroup.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

struct FlowersGroup: View {
    
    let parentGeometry: GeometryProxy
            
    var body: some View {
        
        HStack(alignment: .center) {
            
            Image(FlowerColor.lilac.assetName)
                .resizable()
                .scaledToFit()
                .shadow(color: FlowerColor.lilac.shadowColor, radius: 5)
                .frame(width: 70)
                .transition(.move(edge: .bottom))
                .padding(.bottom, 64)
                .offset(x: 50)
            
            Spacer()
            
            Image(FlowerColor.white.assetName)
                .resizable()
                .scaledToFit()
                .shadow(color: FlowerColor.white.shadowColor, radius: 5)
                .frame(width: 70)
                .transition(.move(edge: .bottom))
                .offset(x: 25)
            
            Spacer()
            
            Image(FlowerColor.lilac.assetName)
                .resizable()
                .scaledToFit()
                .shadow(color: FlowerColor.lilac.shadowColor, radius: 5)
                .frame(width: 70)
                .transition(.move(edge: .bottom))
                .padding(.bottom, 64)
                .offset(x: 50)
            
            Spacer()
            
            Image(FlowerColor.white.assetName)
                .resizable()
                .scaledToFit()
                .shadow(color: FlowerColor.white.shadowColor, radius: 5)
                .frame(width: 70)
                .transition(.move(edge: .bottom))
                .offset(x: 25)
        }
        .padding(.horizontal, 64)
        .padding(.bottom)
        .frame(width: parentGeometry.size.width,
               height: parentGeometry.size.height * 0.4,
               alignment: .bottom)
    }
}
