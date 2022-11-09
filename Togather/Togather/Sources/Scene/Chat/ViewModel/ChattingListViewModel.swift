import Foundation
import Moya

class ChattingListViewModel: ObservableObject {
    let chatClient = MoyaProvider<ChatService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var chattingList: [ChattingList] = []
    
    func fetchChatList() {
        chatClient.request(.fetchChatList) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...300:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ChatListModel.self, from: result.data) {
                        self.chattingList = data.roomList.map { index in
                            let roomID = index.roomID
                            let roomType = index.roomType
                            let roomImageURL = index.roomLogoImage
                            let name = index.roomName
                            let lastChat: LastChatting = LastChatting(
                                lastMessage: index.lastChat.lastMessage,
                                lastSentAt: index.lastChat.lastSentAt
                            )
                            let isRead = index.isRead
                            return ChattingList(
                                roomID: roomID,
                                roomType: roomType,
                                roomLogoImage: roomImageURL,
                                roomName: name,
                                lastChat: lastChat,
                                isRead: isRead
                            )
                        }
                    } else {
                        print("⚠️chat docoder error")
                        print("\(result.statusCode)")
                    }
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️fetch Chatlist error: \(err.localizedDescription)")
            }
        }
    }
}
