import Foundation

// MARK: - MyProfileModel (내 프로필 조회)
struct ProfileModel: Codable {
    let name: String
    let email: String
    let profile_image_url: String
    let introduce: String
    let positions: [String]
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
