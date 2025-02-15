//
//  Wind.swift
//  Pyris
//
//  Created by Federica Mosca on 15/02/25.
//
import SwiftUI

struct WindAnimationView: View {
    @State private var progress: CGFloat = 0.0
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea() // Sfondo (opzionale)
                WindPath(progress: progress)
                    .stroke(Color.white, lineWidth: 2)
                    .opacity(0.8)
                    // Impostiamo il frame usando le dimensioni attuali
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onReceive(timer) { _ in
                progress += 0.005
                if progress > 1.0 {
                    progress = 0.0
                }
            }
        }
    }
}

struct WindPath: Shape {
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Partenza: bordo sinistro, centro verticale
        path.move(to: CGPoint(x: 0, y: height * 0.5))
        // Arrivo: bordo destro, centro verticale
        // I control point sono stati riposizionati per garantire una curva armoniosa su tutto il percorso
        path.addCurve(to: CGPoint(x: width, y: height * 0.5),
                      control1: CGPoint(x: width * 0.25, y: 0),
                      control2: CGPoint(x: width * 0.75, y: height))
        
        // La funzione trimmedPath prende valori tra 0 e 1 che rappresentano la lunghezza totale del percorso.
        // Qui si disegna una porzione dinamica del percorso basata sul valore di progress.
        let start = max(0, progress - 0.1)
        return path.trimmedPath(from: start, to: progress)
    }
}
