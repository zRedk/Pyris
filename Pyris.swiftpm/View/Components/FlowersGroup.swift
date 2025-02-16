//
//  FlowersGroup.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

struct FlowersGroup: View {
    
    let parentGeometry: GeometryProxy
        
    @ObservedObject var viewModel: IntroModel
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            FlowerTappable(
                flowerColor: .lilac,
                flowersToTap: $viewModel.flowersToTap
            )
            .padding(.bottom, 64)
            .offset(x: viewModel.windIsBlowing ? 50: 0)
            .rotationEffect(.degrees(viewModel.windIsBlowing ? 25: 0))
            .animation(
                .linear(duration: 2).repeatForever(autoreverses: true),
                value: viewModel.windIsBlowing
            )
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                flowersToTap: $viewModel.flowersToTap
            )
            .offset(x: viewModel.windIsBlowing ? 25: 0)
            .rotationEffect(.degrees(viewModel.windIsBlowing ? 25: 0))
            .animation(
                .linear(duration: 2).repeatForever(autoreverses: true),
                value: viewModel.windIsBlowing
            )
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .lilac,
                flowersToTap: $viewModel.flowersToTap
            )
            .padding(.bottom, 64)
            .offset(x: viewModel.windIsBlowing ? 25: 0)
            .rotationEffect(.degrees(viewModel.windIsBlowing ? 25: 0))
            .animation(
                .linear(duration: 2).repeatForever(autoreverses: true),
                value: viewModel.windIsBlowing
            )
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                flowersToTap: $viewModel.flowersToTap
            )
            .offset(x: viewModel.windIsBlowing ? 25: 0)
            .rotationEffect(.degrees(viewModel.windIsBlowing ? 25: 0))
            .animation(
                .linear(duration: 2).repeatForever(autoreverses: true),
                value: viewModel.windIsBlowing
            )
        }
        .padding(.horizontal, 64)
        .padding(.bottom)
        .frame(width: parentGeometry.size.width,
               height: parentGeometry.size.height * 0.4,
               alignment: .bottom)
    }
}
