//
//  WindAnimation.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//

import SwiftUI

import Combine

struct WindAnimation: View {
    
    private struct WindPath: Shape {
        var progress: CGFloat
        
        var animatableData: CGFloat {
            get { progress }
            set { progress = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.width
            let height = rect.height
            
            path.move(to: CGPoint(x: 0, y: height * 0.5))
            path.addCurve(to: CGPoint(x: width, y: height * 0.5),
                          control1: CGPoint(x: width * 0.25, y: 0),
                          control2: CGPoint(x: width * 0.75, y: height))
            let start = max(0, progress - 0.1)
            return path.trimmedPath(from: start, to: progress)
        }
    }
    
    private struct WindMetaData: Identifiable {
        let id: UUID = UUID()
        let progressOffset: CGFloat
        let lineWidth: CGFloat
        let shadowRadius: CGFloat
        let stackOffset: CGFloat
    }
    
    @State private var progress: CGFloat = 0.0
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    private let windPaths: [WindMetaData] = [
        .init(progressOffset: 0.05,
              lineWidth: 5,
              shadowRadius: 10,
              stackOffset: 120),
        .init(progressOffset: -0.025,
              lineWidth: 1.5,
              shadowRadius: 6,
              stackOffset: 90),
        .init(progressOffset: 0.025,
              lineWidth: 5,
              shadowRadius: 10,
              stackOffset: 60),
        .init(progressOffset: -0.05,
              lineWidth: 1.5,
              shadowRadius: 6,
              stackOffset: 30),
        .init(progressOffset: 0,
              lineWidth: 5,
              shadowRadius: 10,
              stackOffset: 0),
    ]
    
    private let shouldRepeat: Bool
    
    init(shouldRepeat: Bool = false, slowMultiplier: Double = 1) {
        self.shouldRepeat = shouldRepeat
        
        self.timer = Timer.publish(
            every: 0.01375 * slowMultiplier,
            on: .main,
            in: .common
        ).autoconnect()
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                ForEach(windPaths) { metaData in
                    WindPath(progress: progress + metaData.progressOffset)
                        .stroke(.white, lineWidth: metaData.lineWidth)
                        .shadow(color: .cyan.opacity(0.6) , radius: metaData.shadowRadius)
                        .opacity(0.8)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: metaData.stackOffset)
                }
            }
            .onReceive(timer) { _ in
                
                progress += 0.005
                
                if progress > 1.0 && shouldRepeat {
                    progress = 0.0
                }
            }
        }
    }
}
