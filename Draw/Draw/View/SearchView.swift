import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor1.ignoresSafeArea()
            Text("SEARCH VIEW")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
