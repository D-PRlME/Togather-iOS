import Foundation

// MARK: - TokenModel (로그인, 회원가입, 토큰 재발급)
struct TokenModel: Codable {
    let access_token: String
    let expired_at: String
    let refresh_token: String
}

/*
 {
     "access_token" : "eyksdmsedfa.sdfaecaef.qewdadeqawdrw",
     "expired_at" : "2022-07-18T12:12:12",
     "refresh_token" : "dvghfdfesdf.gyjgjrmgjyjg.ogjiyjghjgg"
 }
 */
