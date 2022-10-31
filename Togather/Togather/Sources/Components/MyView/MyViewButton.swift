import SwiftUI

struct MyViewButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .foregroundColor(.text)
                    .font(.maintext1m)
                    .padding(.leading, 12)
                    .padding(.vertical, 14)
                Spacer()
            }
            .background(Color.whiteElevated1)
            .cornerRadius(8)
        }
    }
}

struct MyViewButton_Previews: PreviewProvider {
    static var previews: some View {
        MyViewButton(text: "개인 정보 보기", action: { })
    }
}
