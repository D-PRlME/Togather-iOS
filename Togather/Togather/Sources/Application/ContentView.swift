import SwiftUI

struct ColorManager {
    static let BackgroundColor: Color = .white
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
