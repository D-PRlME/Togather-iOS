import SwiftUI
import Kingfisher

struct ChatListView: View {
    @StateObject var chattingListViewModel = ChattingListViewModel()
    @State private var gotoChattingView: Bool = false
    @State private var count: Int = 0
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(0..<chattingListViewModel.chattingList.count, id: \.self) { index in
                            Button {
                                gotoChattingView = true
                                count = index
                            } label: {
                                HStack(spacing: 0) {
                                    KFImage.url(URL(string: chattingListViewModel.chattingList[index].roomLogoImage))
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
                                        Text(chattingListViewModel.chattingList[index].roomName)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Bold", size: 20))
                                        Text(chattingListViewModel.chattingList[index].lastChat.lastMessage)
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
                                    ChattingView(index: $count)
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
            chattingListViewModel.fetchChatList()
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
