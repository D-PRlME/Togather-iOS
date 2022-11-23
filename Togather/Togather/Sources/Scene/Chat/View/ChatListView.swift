import SwiftUI
import Kingfisher

struct ChatListView: View {
    @StateObject var chatListViewModel = ChatListViewModel()
    @State private var gotoChattingView: Bool = false
    @State private var selectRoomID: Int = 0
    @State private var selectRoomName: String = ""
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(0..<chatListViewModel.chattingRoomList.count, id: \.self) { index in
                            Button {
                                gotoChattingView = true
                                selectRoomID = chatListViewModel.chattingRoomList[index].roomID
                                selectRoomName = chatListViewModel.chattingRoomList[index].roomName
                            } label: {
                                HStack(spacing: 0) {
                                    KFImage.url(URL(string: chatListViewModel.chattingRoomList[index].roomLogoImage))
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
                                        Text(chatListViewModel.chattingRoomList[index].roomName)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Bold", size: 20))
                                        Text(chatListViewModel.chattingRoomList[index].lastChat.lastMessage)
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
                                    ChattingView(
                                        index: $selectRoomID,
                                        roomName: $selectRoomName
                                    )
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.top, 6)
            }
        }
        .onAppear {
            chatListViewModel.fetchChatList()
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
