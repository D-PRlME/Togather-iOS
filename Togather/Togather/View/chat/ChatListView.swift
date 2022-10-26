import SwiftUI
import Kingfisher

struct ChatListView: View {
    @State private var gotoChattingView: Bool = false
    let user: [String] = [
        "김성원",
        "조병진",
        "김상구",
        "김은빈",
        "홍승재",
        "정승훈",
        "심미진"
    ]
    let lastChat: [String] = [
        "스프린트가 아닌 사이클링",
        "나는 조뼝진 ㅋ",
        "이거진짜살자각인듯",
        "난 백준 플레 ㅋ",
        "Hi! I'm studying SWIFT🔥",
        "Android is power",
        "새우가 주연인 드라마는 대하드라마 엌ㅋㅋㅋㅋㅋㅋㅋㅋ"
    ]
    let Image_url_Arr: [String] = [
        "https://avatars.githubusercontent.com/u/102791105?v=4",
        "https://avatars.githubusercontent.com/u/80248855?v=4",
        "https://avatars.githubusercontent.com/u/76112135?v=4",
        "https://avatars.githubusercontent.com/u/81006587?v=4",
        "https://avatars.githubusercontent.com/u/102791216?v=4",
        "https://avatars.githubusercontent.com/u/102812085?v=4",
        "https://avatars.githubusercontent.com/u/80371353?v=4"
    ]
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(0..<user.count, id: \.self) { index in
                            Button {
                                gotoChattingView = true
                            } label: {
                                HStack(spacing: 0) {
                                    KFImage.url(URL(string: Image_url_Arr[index]))
                                        .placeholder {
                                            Circle()
                                                .fill(Color.secondary)
                                                .opacity(0.1)
                                        }
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 56, height: 56)
                                        .cornerRadius(20)
                                        .padding(1)
                                        .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                        .padding(8)
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(user[index])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Bold", size: 20))
                                        Text(lastChat[index])
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 18))
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                }
                                .background(Color("white-Elevated1"))
                                .frame(width: proxy.size.width - 32)
                                .cornerRadius(8)
                                .fullScreenCover(isPresented: $gotoChattingView) {
                                    ChattingView(index: index)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top, 6)
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
