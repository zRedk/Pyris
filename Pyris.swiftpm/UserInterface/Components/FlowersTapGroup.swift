//
//  FlowersTapGroup.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

struct FlowersTapGroup: View {
    
    let parentGeometry: GeometryProxy
        
    @ObservedObject var viewModel: IntroModel
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            let animationValue: Bool = viewModel.currentPhase == .phase7 ?
                false : viewModel.windIsBlowing
            
            let animation: Animation = viewModel.currentPhase == .phase7 ?
                .linear(duration: 0) : .linear(duration: 2).repeatForever(autoreverses: true)
            
            FlowerTappable(
                flowerColor: .lilac,
                isBurnt: viewModel.currentPhase == .phase7,
                flowersToTap: $viewModel.flowersToTap
            )
            .padding(.bottom, 64)
            .offset(x: animationValue ? 50: 0)
            .rotationEffect(.degrees(animationValue ? 25: 0))
            .animation(animation, value: animationValue)
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                isBurnt: viewModel.currentPhase == .phase7,
                flowersToTap: $viewModel.flowersToTap
            )
            .offset(x: animationValue ? 25: 0)
            .rotationEffect(.degrees(animationValue ? 25: 0))
            .animation(animation, value: animationValue)
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .lilac,
                isBurnt: viewModel.currentPhase == .phase7,
                flowersToTap: $viewModel.flowersToTap
            )
            .padding(.bottom, 64)
            .offset(x: animationValue ? 25: 0)
            .rotationEffect(.degrees(animationValue ? 25: 0))
            .animation(animation, value: animationValue)
            
            Spacer()
            
            FlowerTappable(
                flowerColor: .white,
                isBurnt: viewModel.currentPhase == .phase7,
                flowersToTap: $viewModel.flowersToTap
            )
            .offset(x: animationValue ? 25: 0)
            .rotationEffect(.degrees(animationValue ? 25: 0))
            .animation(animation, value: animationValue)
        }
        .padding(.horizontal, 64)
        .padding(.bottom)
        .frame(width: parentGeometry.size.width,
               height: parentGeometry.size.height * 0.4,
               alignment: .bottom)
    }
}
