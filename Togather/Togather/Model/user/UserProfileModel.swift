import Foundation

// MARK: - UserProfileModel (내 프로필 조회)
struct UserProfileModel: Codable {
    let account_id: String
    let password: String
    let profile_image_url: String
}

/*
 {
     "account_id" : "qweqwe",
     "password" : "password!1",
     "profile_image_url" : "http://"
 }
*/
