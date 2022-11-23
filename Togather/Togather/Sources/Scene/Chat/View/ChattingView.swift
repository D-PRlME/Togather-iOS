import SwiftUI
import Kingfisher

struct ChattingView: View {
    @StateObject var chattingViewModel = ChatListViewModel()
    
    @Environment(\.dismiss) private var dismiss
    @State private var sendChat: String = ""
    @Binding var index: Int
    @Binding var roomName: String
    
    enum WhatDate {
        case month
        case time
    }
    func nowDate(what: WhatDate) -> String {
        let formatterYear = DateFormatter()
        switch what {
        case .month: formatterYear.dateFormat = "MM월 dd일"
        case .time: formatterYear.dateFormat = "HH:mm"
        }
        let currentYearString = formatterYear.string(from: Date())
        return currentYearString
    }
    var body: some View {
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
                    Text(roomName)
                        .font(.custom("Pretendard-Bold", size: 24))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.vertical, 13)
                .background(Color("white-Elevated1"))
                
                ScrollView(showsIndicators: false) {
                    Spacer()
                    
                    VStack(spacing: 12) {
                        ForEach(0..<chattingViewModel.chattingDataList.count, id: \.self) { index in
                            if chattingViewModel.chattingDataList[index].isMine {
                                MyChat(
                                    content: chattingViewModel.chattingDataList[index].message
                                )
                            } else {
                                OpponentChat(
                                    imageUrl: chattingViewModel.chattingDataList[index].user.profileImageURL,
                                    user: chattingViewModel.chattingDataList[index].user.userName,
                                    chatContent: chattingViewModel.chattingDataList[index].message,
                                    date: chattingViewModel.chattingDataList[index].sentAt
                                )
                            }
                        }
//                        DividingLine(
//                            when: nowDate(what: .month)
//                        )
                    }
                    Spacer()
                        .frame(height: 20)
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
                        chattingViewModel.sendMessage = sendChat
                        chattingViewModel.sendChat()
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
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
            }
        }
        .onAppear {
            chattingViewModel.roomID = index
            chattingViewModel.socketSetting()
            chattingViewModel.fetchChat()
            
        }
        .navigationBarHidden(true)
    }
}

struct ChattingView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView(index: .constant(6), roomName: .constant("김"))
    }
}
