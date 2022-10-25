import SwiftUI

struct MyChat: View {
    let content: String
    var body: some View {
        HStack {
            Spacer()
            Text(content)
                .foregroundColor(.black)
                .font(.custom("Pretendard-Medium", size: 18))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color("main-Elevated"))
                .cornerRadius(24)
                .padding(1)
                .background(Color("main-Darken"))
                .cornerRadius(24)
        }
    }
}

struct MyChat_Previews: PreviewProvider {
    static var previews: some View {
        MyChat(content: "에베베베베")
    }
}
