import Foundation

// MARK: - LookUpMyProfileModel (내 프로필 조회)
struct LookUpProfileModel: Codable {
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
