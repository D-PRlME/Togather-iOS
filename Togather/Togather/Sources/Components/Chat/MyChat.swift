import SwiftUI

struct MyChat: View {
    let content: String
    let date: String
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Spacer()
            Text(date)
                .foregroundColor(Color.whiteElevated4)
                .font(.indicator)
            Text(content)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .font(.maintext1m)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.mainElevated)
                .cornerRadius(24)
                .padding(1)
                .background(Color.mainDarken)
                .cornerRadius(24)
        }
    }
}

struct MyChat_Previews: PreviewProvider {
    static var previews: some View {
        MyChat(content: "에베베베베", date: "오전 11:12")
    }
}
