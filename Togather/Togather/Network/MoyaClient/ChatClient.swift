import Foundation
import Moya

enum ChatService {
    case fetchChatList
    case creatIndividualChat(userID: Int)
    case fetchChat(roomID: Int)
}

extension ChatService: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.55.240.35:8080/chats")!
    }
    var path: String {
        switch self {
        case .fetchChatList, .creatIndividualChat:
            return "/room"
        case .fetchChat(let roomID):
            return "/\(roomID)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchChatList, .fetchChat:
            return .get
        case .creatIndividualChat:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .fetchChat:
            return .requestParameters(
                parameters:
                    [
                        "time": "\(Date().timeFormater())"
                    ],
                encoding: URLEncoding.default)
        case .creatIndividualChat(let userID):
            return .requestParameters(
                parameters:
                    [
                        "user_id": userID
                    ],
                encoding: JSONEncoding.default)
        case .fetchChatList:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .fetchChat, .creatIndividualChat, .fetchChatList:
            return Header.accessToken.header()
        }
    }
}
