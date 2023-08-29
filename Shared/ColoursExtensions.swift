import SwiftUI

extension Color {
    static let primaryBackground = Color("primaryBackground")
    static let primaryForeground = Color("primaryForeground")
    static let accentColor = Color("accentColor")
}

struct AppButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
