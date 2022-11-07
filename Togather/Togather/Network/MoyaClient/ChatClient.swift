import Foundation
import Moya

enum ChatService {
    case fetchChatList
    case creatIndividualChat(roomID: Int, page: Int)
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
        case .fetchChat(let userID):
            return "/\(userID)"
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
        case .fetchChat, .creatIndividualChat, .fetchChatList:
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        case .fetchChat, .creatIndividualChat, .fetchChatList:
            return Header.accessToken.header()
        }
    }
}
