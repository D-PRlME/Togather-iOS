import SwiftUI
import Kingfisher

struct PostInfoForm: View {
    let title: String
    let imageLink: String
    let userName: String
    let createdAt: String
    let userID: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.black)
                .font(.title2b)
                .padding(.top, 7)
            
            HStack(spacing: 8) {
                NavigationLink (destination: UserProfileView(userID: userID)) {
                    KFImage.url(URL(string: imageLink))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 33, height: 33)
                        .cornerRadius(20)
                        .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                }
                Text(userName)
                    .foregroundColor(.text)
                    .font(.maintext2m)
                Spacer()
                Text(createdAt)
                    .foregroundColor(.whiteElevated4)
                    .font(.maintext2m)
            }
        }
    }
}

struct PostInfoForm_Previews: PreviewProvider {
    static var previews: some View {
        PostInfoForm(
            title: "제목",
            imageLink: "",
            userName: "조병진",
            createdAt: "2022-10-32 / 5",
            userID: 0
        )
    }
}
