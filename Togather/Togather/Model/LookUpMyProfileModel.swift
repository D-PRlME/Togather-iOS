import Foundation

// MARK: - LookUpMyProfileModel (내 프로필 조회)
struct LookUpMyProfileModel: Codable {
    let account_id: String
    let email: String
    let picture: String
}

/*
 {
    "account_id" : "qweqwe",
    "email" : "email.dsm.hs.kr",
    "picture" : "sasdlfkgjaglvsla.jpg"
 }
*/
