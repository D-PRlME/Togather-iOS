
import SwiftUI

struct ColorManager {
    // create static variables for custom colors
    static let BackgroundColor1: Color = .white
    static let BackgroundColor2: Color = .white
    static let BackgroundColor3: Color = .white
    
    //... add the rest of your colors here
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
