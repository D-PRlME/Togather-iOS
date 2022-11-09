import SwiftUI
import Kingfisher

struct OpponentChat: View {
    let imageUrl: String
    let user: String
    let chatContent: String
    let date: String
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            KFImage.url(URL(string: imageUrl))
                .placeholder {
                    Circle()
                        .fill(Color.secondary)
                        .opacity(0.1)
                }
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 48, height: 48)
                .cornerRadius(20)
                .padding(1)
                .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
            VStack(alignment: .leading, spacing: 0) {
                Text(user)
                    .foregroundColor(Color("text1"))
                    .font(.custom("Pretendard-ExtraBold", size: 14))
                    .padding(.bottom, 4)
                    .padding(.leading, 4)
                Text(chatContent)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .font(.custom("Pretendard-Medium", size: 18))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color("white-Elevated2"))
                    .cornerRadius(24)
                    .padding(1)
                    .background(Color("TabBarStroke"))
                    .cornerRadius(24)
            }
            Text(date)
                .foregroundColor(Color("text1"))
                .font(.custom("Pretendard-ExtraBold", size: 14))
            Spacer()
        }
    }
}

struct OpponentChat_Previews: PreviewProvider {
    static var previews: some View {
        OpponentChat(imageUrl: "https://avatars.githubusercontent.com/u/102791216?v=4",
                     user: "Reswo._.", chatContent: "helloWorld", date: "오전 7:22")
    }
}
