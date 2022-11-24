import Foundation
import SocketIO

final class SocketViewModel: ObservableObject {
    @Published var message = [String]()
    private var manager = SocketManager(
        socketURL: URL(string: "http://52.55.240.35:8081")!,
        config: [
            .log(true),
            .compress
        ]
    )
    var socket: SocketIOClient!
    init() {
        self.manager.config = SocketIOClientConfiguration(arrayLiteral: .extraHeaders(["Authorization": "Bearer " + (Token.localAccessToken ?? "")]), .version(.two), .path("/socket.io"), .reconnects(true))
        self.socket = self.manager.defaultSocket
        socketSetting()
        socket.connect()
    }
    deinit {
        socket.disconnect()
    }
    func socketSetting() {
        self.onError()
        self.onChat()
    }
    func socketCounnect() {
        socket.connect()
        socket.on(clientEvent: .connect) { _, _ in
            print("✅서버에 연결되었습니다")
        }
    }
    func socketDisconnect() {
        socket.disconnect()
    }
    func onError() {
        socket.on("error") { (dataArrya, ack) in
            print("에러 타입: \(type(of: dataArrya))")
            print("에러: \(dataArrya), \(ack)")
//            let data = dataArrya[0] as! NSDictionary
//            print(data["code"] as! String)
        }
    }
    func onChat() {
        socket.on("chat") { (dataArrya, ack) in
            print("chat 타입: \(type(of: dataArrya))")
            print("chat: \(dataArrya), \(ack)")
//            let data = dataArrya[0] as! NSDictionary
//            print(data["code"] as! String)
        }
    }
    func onRoom() {
        socket.emit("join", ["is_join_room": true, "room_id": 2])
    }
    func sendChat() {
        socket.emit("chat", ["message": "테슷트 입니다"])
    }

}
