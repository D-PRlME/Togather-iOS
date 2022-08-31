
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor1.ignoresSafeArea()
            Text("HOME VIEW")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
