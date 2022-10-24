import SwiftUI

struct SignUpTitle: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("ToGather")
                .font(.titleXLb)
                .foregroundColor(.main)
            Text("시작하기")
                .font(.titleXLb)
                .foregroundColor(.text)
        }
    }
}

struct SignUpTitle_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTitle()
    }
}
