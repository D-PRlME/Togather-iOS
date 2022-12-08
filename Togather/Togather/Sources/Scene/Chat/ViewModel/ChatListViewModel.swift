import Foundation
import Moya
import SocketIO

class ChatListViewModel: ObservableObject {
    let chatClient = MoyaProvider<ChatService>(plugins: [MoyaLoggerPlugin()])
    @Published var chattingRoomList: [ChattingRoomList] = []
    func fetchChatList() {
        chatClient.request(.fetchChatList) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...300:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ChatListModel.self, from: result.data) {
                        self.chattingRoomList = data.roomList.map { index in
                            let roomID = index.roomID
                            let roomType = index.roomType
                            let roomImageURL = index.roomLogoImage
                            let name = index.roomName
                            let lastChat: LastChatting = LastChatting(
                                lastMessage: index.lastChat.lastMessage,
                                lastSentAt: index.lastChat.lastSentAt
                            )
                            let isRead = index.isRead
                            return ChattingRoomList(
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

/*
 "chat_list" : [
     {
         "user" : {
             "user_id" : 1,
             "user_name" : "김은빈",
             "profile_image_url" : "http://"
         },
         "message" : "안녕하세요?",
         "sent_at" : "오전 11:47"
     },
     {
         "user" : {
             "user_id" : 2,
             "user_name" : "김금빈",
             "profile_image_url" : "http://"
         },
         "message" : "안녕하세요!",
         "sent_at" : "오전 11:48"
     },
 ]
 */

/*
 [{
     "is_mine" = 1;
     message = "\Ubc84\Uadf8\Uc778 \Uac70\Uc2e0\Uac00..!";
     "room_id" = 2;
     "sent_at" = "\Uc624\Ud6c4 15:23";
     user =     {
         "profile_image_url" = "https://wouldyou1214.s3.amazonaws.com/DefaultUser.png";
         "user_id" = 4;
         "user_name" = "\Uc870\Ubcd1\Uc9c4";
     };
 }]
 */
