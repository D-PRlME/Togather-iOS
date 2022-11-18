import Foundation

// MARK: - MyProfileModel (내 프로필 조회)
struct ChangePasswordModel: Codable {
    let userID: Int
    let name, email, profileImageURL, introduce: String
    let positions: [String]

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, email
        case profileImageURL = "profile_image_url"
        case introduce, positions
    }
}

/*
 {
     "name" : "김은빈",
     "email" : "email@dsm.hs.kr",
     "profile_image_url" : "http://",
     "introduce":"백엔드 일짱임. 디코 아이디는 김은빈#1234",
     "position":["BACKEND"]
 }
*/
