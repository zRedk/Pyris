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
        
        GeometryReader { geometry in
            
            ZStack {
                
                Image("Woods")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .opacity(0.7)
                    .overlay {
                        LinearGradient(
                            colors: [.init("FireColor"), .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity({
                            switch viewModel.currentSession {
                            case 1: 0.8
                            case 2: 0.6
                            case 3: 0.3
                            default: 0
                            }
                        }())
                    }
                    .animation(.easeInOut, value: viewModel.currentSession)
                
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
                        .frame(width: 400 * viewModel.activityLevel)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.activityLevel)
                    
                    ProgressBar(progress: min(CGFloat(viewModel.blowingTime / viewModel.requiredBlowingTime), 1.0))
                        .frame(width: 600)
                        .padding()
                }
                .onChange(of: viewModel.gameCompleted) { isCompleted in
                    if isCompleted { setSceneMode(.endGame) }
                }
                
                WindAnimationView(
                    shouldRepeat: true,
                    slowMultiplier: min(0.6 * Double(viewModel.currentSession), 1.5)
                )
                .offset(y: 50)
                
                WindAnimationView(
                    shouldRepeat: true,
                    slowMultiplier: min(0.6 * Double(viewModel.currentSession), 1.5)
                )
                .offset(y: 150)
            }
            .task(priority: .userInitiated) { @MainActor in
                await viewModel.startActivity()
            }
            
        }
    }
}
