import Foundation

struct ErrorModel: Codable {
    let status: Int
    let code: String
    let message: String
}

/*
 {
     "status": 401,
     "code": "USER-401-1",
     "message": "Unverified Email"
 }
 */
