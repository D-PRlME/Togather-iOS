
import SwiftUI

struct MyView: View {
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor3.ignoresSafeArea()
            Text("MY VIEW")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
