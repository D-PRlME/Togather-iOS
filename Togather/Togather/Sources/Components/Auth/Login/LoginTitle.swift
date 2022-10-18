import SwiftUI

struct LoginTitle: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("마음 맞는 팀원을 찾는 \n간단한 방법.")
                .foregroundColor(.text)
                .font(.titleXLb)
            Text("ToGather")
                .foregroundColor(.main)
                .font(.titleXLb)
        }
    }
}

struct LoginTitle_Previews: PreviewProvider {
    static var previews: some View {
        LoginTitle()
    }
}
