import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct UserProfileView: View {
    let userID: Int
    @StateObject var userProfileViewModel = UserProfileViewModel()
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 12) {
                    KFImage.url(URL(string: userProfileViewModel.userProfileImageURL))
                        .placeholder {
                            Circle().fill(Color.whiteElevated3)
                                .frame(width: 72, height: 72)
                        }
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 72, height: 72)
                        .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                    VStack(alignment: .leading) {
                        Text(userProfileViewModel.userName)
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Bold", size: 28))
                        Text(userProfileViewModel.userEmail)
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 20))
                    }
                    Spacer()
                }
                .padding(.bottom, 4)
                FlowLayout(mode: .scrollable,
                           items: userProfileViewModel.userPositions,
                           itemSpacing: 4) {
                    Text($0)
                        .foregroundColor(.text)
                        .font(.maintext2m)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.whiteElevated2)
                        .cornerRadius(37)
                        .overlay(
                            RoundedRectangle(cornerRadius: 37)
                                .stroke(style: .init(lineWidth: 1))
                                .foregroundColor(.whiteElevated3)
                        )
                }
                Text(userProfileViewModel.userIntroduce)
                    .foregroundColor(.black)
                    .font(.title3m)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 8)
                    .padding(.horizontal, 6)
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
            .padding(.top, 60)
            BackBtn()
                .padding(.top, 10)
        }
        .onAppear {
            userProfileViewModel.userID = self.userID
            userProfileViewModel.getUserProfile()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userID: 1)
    }
}
