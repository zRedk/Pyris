//
//  FlowersGroup.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

struct FlowersGroup: View {
    
    let parentGeometry: GeometryProxy
    
    @Binding var flowersToTap: Int
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            FlowerTappable(
                flowerColor: .lilac,
                flowersToTap: $flowersToTap
            )
            .padding(.bottom, 64)
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                flowersToTap: $flowersToTap
            )
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .lilac,
                flowersToTap: $flowersToTap
            )
            .padding(.bottom, 64)
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                flowersToTap: $flowersToTap
            )
        }
        .padding(.horizontal, 64)
        .padding(.bottom)
        .frame(width: parentGeometry.size.width,
               height: parentGeometry.size.height * 0.4,
               alignment: .bottom)
    }
}
