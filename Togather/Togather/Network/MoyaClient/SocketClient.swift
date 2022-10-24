import Foundation
import Moya

enum SocketService {
    case socketConuet
}

extension SocketService: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.35.113.190:8080/socket.io")!
    }
    
    var path: String {
        switch self {
        case .socketConuet:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socketConuet:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .socketConuet:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .socketConuet:
            return Header.accessToken.header()
        }
    }
}
