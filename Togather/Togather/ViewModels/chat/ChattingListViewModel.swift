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
                        self.chattingList = data.room_list.map { index in
                            let roomID = index.room_id
                            let roomType = index.room_type
                            let roomImageURL = index.room_logo_image
                            let name = index.room_name
                            let lastChat: LastChatting = LastChatting(
                                last_message: index.last_chat.last_message,
                                last_sent_at: index.last_chat.last_sent_at
                            )
                            let isRead = index.is_read
                            return ChattingList(
                                room_id: roomID,
                                room_type: roomType,
                                room_logo_image: roomImageURL,
                                room_name: name,
                                last_chat: lastChat,
                                is_read: isRead
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
