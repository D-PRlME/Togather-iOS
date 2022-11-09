import Foundation

// MARK: - TokenModel (로그인, 회원가입, 토큰 재발급)
struct TokenModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiredAt = "expired_at"
        case refreshToken = "refresh_token"
    }
    let accessToken: String
    let expiredAt: String
    let refreshToken: String
}

struct RefreshTokenModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    let accessToken: String
    let refreshToken: String
}
