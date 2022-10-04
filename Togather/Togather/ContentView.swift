
import SwiftUI

struct ColorManager {
    // create static variables for custom colors
    static let BackgroundColor1: Color = .white
    static let BackgroundColor2: Color = .white
    static let BackgroundColor3: Color = .white
    
    //... add the rest of your colors here
}

@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
        NavigationView {
            SignInView()
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
