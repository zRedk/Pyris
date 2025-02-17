import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var currentSceneMode: SceneMode = .launch
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                
                Color.black
                
                switch currentSceneMode{
                case .launch: LauchView()
                case .intro: IntroView()
                case .tutorial: TutorialView()
                case .game: GameView()
                case .endGame: EndGameView()
                }
            }
            .ignoresSafeArea()
            .statusBarHidden(true)
            .environment(\.setSceneMode, setSceneMode)
            .environmentObject(viewModel)
        }
    }
    
    private func setSceneMode(_ mode: SceneMode) {
        currentSceneMode = mode
    }
}
