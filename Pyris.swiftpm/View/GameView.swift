import SwiftUI
import AVFoundation

struct GameView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    @Environment(\.setSceneMode) private var setSceneMode
    
    private var backgroundImage: String {
        switch viewModel.currentSession {
        case 1: "background_fire"
        case 2: "background_fire_low"
        case 3: "background_fire_lowest"
        default: "background"
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                if let message = viewModel.motivationalMessage {
                    Text(message)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.motivationalMessage)
                }
                
                Image("Pyris")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450 * viewModel.activityLevel)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.activityLevel)
                
                
                ProgressBar(progress: min(CGFloat(viewModel.blowingTime / viewModel.requiredBlowingTime), 1.0))
                    .frame(width: 600)
                    .padding()
            }
            .onChange(of: viewModel.gameCompleted) { isCompleted in
                if isCompleted { setSceneMode(.endGame) }
            }
        }
        .task(priority: .userInitiated) { @MainActor in
            await viewModel.startActivity()
        }
    }
}
