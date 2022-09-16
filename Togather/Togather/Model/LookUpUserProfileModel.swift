import Foundation

// MARK: - LookUpUserProfileModel (유저 프로필 조회)
struct LookUpUserProfileModel: Codable {
    let accountID, password: String
}

/*
{
    "account_id" : "qweqwe",
    "password" : "password!1"
}
*/
