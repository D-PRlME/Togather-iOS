import Foundation
import Moya
import SocketIO

// swiftlint:disable force_cast
// swiftlint:disable identifier_name
class ChattingViewModel: ObservableObject {
    private let chatClient = MoyaProvider<ChatService>(plugins: [MoyaLoggerPlugin()])
    private var manager = SocketManager(
        socketURL: URL(string: "http://52.55.240.35:8081")!,
        config: [
            .log(false),
            .compress
        ]
    )
    private let socket: SocketIOClient!
    @Published var showSkeleton: Bool = true
    @Published var chattingDataList: [ChattingDataLocalModel] = []
    @Published var sendMessage: String = ""
    @Published var socketStatus: Bool?
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
    func listSocketCounnect() {
        socket.connect()
        self.onError()
        self.onChat()
        socket.on(clientEvent: .connect) { _, _ in
            print("✅소켓서버에 연결되었습니다")
            self.quitRoom()

        }
        socket.on(clientEvent: .disconnect) { _, _ in
            print("🚫소켓서버에 연결해제 되었습니다")
        }
    }
    func socketCounnect() {
        socket.connect()
        self.onError()
        self.onChat()
        socket.on(clientEvent: .connect) { _, _ in
            print("✅소켓서버에 연결되었습니다")
            self.joinRoom()
            self.socketStatus = true
        }
        socket.on(clientEvent: .disconnect) { _, _ in
            print("🚫소켓서버에 연결해제 되었습니다")
            self.socketStatus = false
        }
    }
    func socketDisconnect() {
        socket.didDisconnect(reason: "소켓 종료")
    }
    func onError() {
        socket.on("error") { (dataArrya, _) in
            print("에러: \(dataArrya)")
        }
    }
    func onChat() {
        socket.on("chat") { (dataArrya, _) in
            let stringInData = dataArrya[0] as! String
            let inputData = stringInData.data(using: .utf8)!
            let Decoder = JSONDecoder()
            DispatchQueue.main.async {
                if let messageData = try? Decoder.decode(ChatList.self, from: inputData) {
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
    }
    func quitRoom() {
        socket.emit("join", ["is_join_room": false])
    }
    func joinRoom() {
        socket.emit("join", ["is_join_room": true, "room_id": roomID])
    }
    func sendChat() {
        socket.emit("chat2", ["message": sendMessage])
    }
    func fetchChat() {
        chatClient.request(.fetchChat(roomID: roomID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    DispatchQueue.main.async {
                        if let data = try? decoder.decode(ChattingDataModel.self, from: result.data) {
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
                            self.showSkeleton = false
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
