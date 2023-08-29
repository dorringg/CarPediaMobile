import SwiftUI
import Firebase

@main
struct CarPediaApp: App {
    @StateObject private var viewModel = CarListViewModel()

    init() {
        FirebaseApp.configure()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]

        UINavigationBar.appearance().tintColor = .systemTeal
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }


    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

