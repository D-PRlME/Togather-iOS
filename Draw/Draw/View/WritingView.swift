
import SwiftUI

struct WritingView: View {
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor2.ignoresSafeArea()
            Text("WRITING VIEW")
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
