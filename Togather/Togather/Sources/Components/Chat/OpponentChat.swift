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
                        .fill(Color.whiteElevated3)
                }
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)
                .cornerRadius(20)
                .padding(1)
                .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
            VStack(alignment: .leading, spacing: 0) {
                Text(user)
                    .foregroundColor(.whiteElevated4)
                    .font(.indicator)
                    .padding([.bottom, .leading], 4)
                Text(chatContent)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .font(.maintext1m)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.whiteElevated2)
                    .cornerRadius(24)
                    .padding(1)
                    .background(Color.whiteElevated3)
                    .cornerRadius(24)
            }
            Text(date)
                .foregroundColor(Color.whiteElevated4)
                .font(.indicator)
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
