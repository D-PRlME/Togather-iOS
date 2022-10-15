
import SwiftUI

struct ColorManager {
    static let BackgroundColor: Color = .white
}

@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
//            SocketTest()
                .navigationBarHidden(true)
        }
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
