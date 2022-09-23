import Foundation

// MARK: - MyProfileModel (내 프로필 조회)
struct MyProfileModel: Codable {
    let name: String
    let email: String
    let profile_image_url: String
}

/*
 {
    "name" : "qweqwe",
    "email" : "email.dsm.hs.kr",
    "profile_image_url" : "sasdlfkgjaglvsla.jpg"
 }
*/
