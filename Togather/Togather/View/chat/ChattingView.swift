import SwiftUI
import Kingfisher

struct ChattingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var sendChat: String = ""
    @Binding var index: Int
    let user: [String] = [
        "김성원",
        "조병진",
        "김상구",
        "김은빈",
        "홍승재",
        "정승훈",
        "심미진"
    ]
    let chatContent: [String] = [
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
    enum whatDate {
        case month
        case time
    }
    func nowDate(what: whatDate) -> String {
        let formatter_year = DateFormatter()
        switch what {
        case .month: formatter_year.dateFormat = "MM월 dd일"
        case .time: formatter_year.dateFormat = "HH:mm"
        }
        let current_year_string = formatter_year.string(from: Date())
        return current_year_string
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image("back")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .onTapGesture {
                                dismiss()
                            }
                        Text(user[index])
                            .font(.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 13)
                    .background(Color("white-Elevated1"))
                    ScrollView {
                        VStack(spacing: 12) {
                            Spacer()
                                .frame(height: 30)
                            OpponentChat(
                                image_url: Image_url_Arr[index],
                                user: user[index],
                                chatContent: chatContent[index],
                                date: nowDate(what: .time)
                            )
                            MyChat(
                                content: "진짜 넌 나가죽어라"
                            )
                            DividingLine(
                                when: nowDate(what: .month)
                            )
                            OpponentChat(
                                image_url: Image_url_Arr[index],
                                user: user[index],
                                chatContent: "이거진짜살자각인듯",
                                date: nowDate(what: .time)
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    HStack(spacing: 8) {
                        TextField("채팅", text: $sendChat)
                            .padding(12)
                            .background(Color("white-Elevated1"))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .multilineTextAlignment(.leading)
                        Button {
                            print("보낼 채팅: \(sendChat)")
                            sendChat = ""
                        } label: {
                            Text("전송")
                                .font(.maintext1m)
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.main)
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color.mainDarken)
                                .cornerRadius(37)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ChattingView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView(index: .constant(4))
    }
}
