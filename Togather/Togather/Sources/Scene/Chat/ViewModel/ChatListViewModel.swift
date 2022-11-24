import Foundation
import Moya
import SocketIO

class ChatListViewModel: ObservableObject {
    let chatClient = MoyaProvider<ChatService>(plugins: [MoyaLoggerPlugin()])
    private var manager = SocketManager(
        socketURL: URL(string: "http://52.55.240.35:8081")!,
        config: [
            .log(true),
            .compress
        ]
    )
    var socket: SocketIOClient!
    
    @Published var chattingRoomList: [ChattingRoomList] = []
    @Published var chattingDataList: [ChattingDataLocalModel] = []
    @Published var sendMessage: String = ""
    var roomID: Int = 0
    
    init() {
        self.manager.config = SocketIOClientConfiguration(
            arrayLiteral:
                .extraHeaders(["Authorization": "Bearer " + (Token.localAccessToken ?? "")]),
                .version(.two),
                .path("/socket.io"),
                .reconnects(true)
        )
        self.socket = self.manager.defaultSocket
    }
    
    deinit {
        socket.disconnect()
    }
    
    func socketSetting() {
        socketCounnect()
        self.onError()
        self.onChat()
    }
    
    func socketCounnect() {
        socket.connect()
        
        socket.on(clientEvent: .connect) { _, _ in
            print("✅소켓서버에 연결되었습니다")
            self.joinRoom()
        }
    }
    
    func socketDisconnect() {
        socket.disconnect()
    }
    
    func onError() {
        socket.on("error") { (dataArrya, _) in
            print("에러: \(dataArrya)")
        }
    }
    
    func onChat() {
        socket.on("chat") { (dataArrya, _) in
            let Decoder = JSONDecoder()
            if let messageData = try? Decoder.decode(ChatList.self, from: dataArrya[0] as! Data) {
                self.chattingDataList.append(
                    ChattingDataLocalModel(
                        user: ChattingUserLocal(
                            userID: messageData.user.userID,
                            userName: messageData.user.userName,
                            profileImageURL: messageData.user.profileImageURL
                        ),
                        message: messageData.message,
                        roomID: messageData.roomID,
                        isMine: messageData.isMine,
                        sentAt: messageData.sentAt
                    )
                )
            } else {
                print("🚫 socket decoder error")
            }
        }
    }
    
    func joinRoom() {
        socket.emit("join", ["is_join_room": true, "room_id": roomID])
    }
    
    func sendChat() {
        socket.emit("chat", ["message" : sendMessage])
    }
    
    
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
    
    func fetchChat() {
        chatClient.request(.fetchChat(roomID: roomID, page: 0)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    DispatchQueue.main.async {
                        if let data = try? decoder.decode(ChattingDataMadel.self, from: result.data) {
                            self.chattingDataList = data.chatList.map {
                                let user: ChattingUserLocal = ChattingUserLocal(
                                    userID: $0.user.userID,
                                    userName: $0.user.userName,
                                    profileImageURL: $0.user.profileImageURL
                                )
                                let message = $0.message
                                let roomID = $0.roomID
                                let isMine = $0.isMine
                                let sentAt = $0.sentAt
                                
                                return ChattingDataLocalModel(user: user, message: message, roomID: roomID, isMine: isMine, sentAt: sentAt)
                            }
                        } else {
                            print("⚠️featch chat docoder error")
                        }
                    }
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️fetch Chat error: \(err.localizedDescription)")
                
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
