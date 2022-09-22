import Foundation
import ReactiveSwift


struct Token {
    static var _accessToken: String?
    static var accessToken: String? {
        get {
            _accessToken =  UserDefaults.standard.string(forKey: "acccess_token")
            return _accessToken
        }
        
        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "acccess_token")
            _accessToken = newToken
        }
    }
    
    static var _refreshToken: String?
    static var refreshToken: String? {
        get {
            _refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
            return _refreshToken
        }
        
        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "refresh_token")
            _refreshToken = newToken
        }
    }
    
    static func removeToken() {
        self.refreshToken = nil
        self.accessToken = nil
    }
}

enum Header {
    case refreshToken, accessToken, tokenIsEmpty
    
    func header() -> [String : String]? {
        guard let token = Token.accessToken else {
            return ["Content-Type" : "application/json"]
        }
        
        guard let refreshToken = Token.refreshToken else {
            return ["Content-Type" : "application/json"]
        }
        
        switch self {
        case .refreshToken:
            return ["X-Refresh-Token" : refreshToken, "Content-Type" : "application/json"]
        case .accessToken:
            return ["Authorization" : "Bearer " + token, "Content-Type" : "application/json"]
        case .tokenIsEmpty:
            return ["Content-Type" : "application/json"]
        }
    }
}
