import Foundation
import SwiftKeychainWrapper

struct Token {
    static var localAccessToken: String?
    static var accessToken: String? {
        get {
            localAccessToken =  KeychainWrapper.standard.string(forKey: "acccess_token")
            return localAccessToken
        }
        set(newToken) {
            KeychainWrapper.standard.set(newToken ?? "nil", forKey: "acccess_token")
            localAccessToken = newToken
        }
    }
    static var localRefreshToken: String?
    static var refreshToken: String? {
        get {
            localRefreshToken = KeychainWrapper.standard.string(forKey: "refresh_token")
            return localRefreshToken
        }
        set(newToken) {
            KeychainWrapper.standard.set(newToken ?? "nil", forKey: "refresh_token")
            localRefreshToken = newToken
        }
    }
    static func removeToken() {
        self.refreshToken = nil
        self.accessToken = nil
    }
}

enum Header {
    case refreshToken, accessToken, tokenIsEmpty
    func header() -> [String: String]? {
        guard let token = Token.accessToken else {
            return ["Content-Type": "application/json"]
        }
        guard let refreshToken = Token.refreshToken else {
            return ["Content-Type": "application/json"]
        }
        switch self {
        case .refreshToken:
            return ["X-Refresh-Token": refreshToken, "Content-Type": "application/json"]
        case .accessToken:
            return ["Authorization": "Bearer " + token, "Content-Type": "application/json"]
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        }
    }
}
