import Foundation

// MARK: - TokenModel (로그인, 회원가입, 토큰 재발급)
struct TokenModel: Codable {
    let access_token: String
    let expired_at: String
    let refresh_token: String
}

struct RefreshTokenModel: Codable {
    let access_token: String
    let refresh_token: String
}
