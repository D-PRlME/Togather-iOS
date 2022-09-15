import Foundation

// MARK: - MyProfileModel (내 프로필 조회)
struct MyProfileModel: Codable {
    let account_id: String
    let email: String
    let profile_image_url: String
}

/*
 {
    "account_id" : "qweqwe",
    "email" : "email.dsm.hs.kr",
    "profile_image_url" : "sasdlfkgjaglvsla.jpg"
 }
*/
