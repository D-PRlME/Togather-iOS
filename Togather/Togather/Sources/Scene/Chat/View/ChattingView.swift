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
        BackgroundTapGesture {
            ZStack(alignment: .top) {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        Image("back")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .onTapGesture {
                                dismiss()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    chattingViewModel.socketDisconnect()
                                }
                            }
                        Text(roomName)
                            .font(.title2b)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 13)
                    .background(Color.whiteElevated1)
                    GeometryReader { proxy in
                        ScrollView(showsIndicators: false) {
                            Spacer()
                            VStack(spacing: 12) {
                                if chattingViewModel.showSkeleton {
                                    ChattingSkeleton()
                                } else if chattingViewModel.chattingDataList.isEmpty {
                                    VStack {
                                        Image("gray_logo")
                                            .resizable()
                                            .frame(width: 119, height: 119)
                                        Text(roomName + "님과의 채팅이에요")
                                            .font(.title1b)
                                            .foregroundColor(.whiteElevated4)
                                        Text("채팅을 시작해보세요!")
                                            .font(.title3m)
                                            .foregroundColor(.whiteElevated4)
                                    }
                                    .padding(.bottom, proxy.size.height / 3)
                                }
                                ForEach(0..<chattingViewModel.chattingDataList.count, id: \.self) { index in
                                    if chattingViewModel.chattingDataList[index].isMine {
                                        MyChat(
                                            content: chattingViewModel.chattingDataList[index].message,
                                            date: chattingViewModel.chattingDataList[index].sentAt
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
                                Rectangle()
                                    .frame(height: 0)
        //                        DividingLine(
        //                            when: nowDate(what: .month)
        //                        )
                            }
                            .rotationEffect(Angle(degrees: 180))
                            Spacer()
                                .frame(height: 20)
                        }
                        .rotationEffect(Angle(degrees: 180))
                        .padding(.horizontal, 16)
                    }
                    ZStack {
                        HStack {
                            TextField("", text: $sendChat)
                                .disableAutocorrection(true)
                                .padding(12)
                                .background(.white)
                                .cornerRadius(65)
                                .multilineTextAlignment(.leading)
                            Button {
                                if !sendChat.isEmpty {
                                    chattingViewModel.sendMessage = sendChat
                                    chattingViewModel.sendChat()
                                    sendChat = ""
                                }
                            } label: {
                                Text("전송")
                                    .font(.maintext1m)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.main)
                                    .cornerRadius(65)
                                    .padding(2)
                                    .background(Color.mainDarken)
                                    .cornerRadius(65)
                            }
                            .padding(.trailing, 5)
                        }
                        .background(.white)
                        .cornerRadius(65)
                        .overlay(
                            RoundedRectangle(cornerRadius: 65)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .foregroundColor(.whiteElevated3)
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding([.top, .bottom], 8)
                    .background(Color.whiteElevated1)
                }
            }
            .onAppear {
                print("시간: \(Date().timeFormater())")
                chattingViewModel.roomID = index
                chattingViewModel.socketCounnect()
                chattingViewModel.fetchChat()
            }
            .navigationBarHidden(true)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ChattingView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView(index: .constant(6), roomName: .constant("김"))
    }
}
