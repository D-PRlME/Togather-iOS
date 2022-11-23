import Foundation

struct ChattingDataMadel: Codable {
    let page: Int
    let chatList: [ChatList]
    
    enum CodingKeys: String, CodingKey {
        case page
        case chatList = "chat_list"
    }
}

struct ChatList: Codable {
    let user: ChattingUser
    let message: String
    let roomID: Int
    let isMine: Bool
    let sentAt: String

    enum CodingKeys: String, CodingKey {
        case user, message
        case roomID = "room_id"
        case sentAt = "sent_at"
        case isMine = "is_mine"
        
    }
}

struct ChattingUser: Codable {
    let userID: Int
    let userName: String
    let profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case profileImageURL = "profile_image_url"
    }
}

struct ChattingDataLocalModel {
    let user: ChattingUserLocal
    let message: String
    let roomID: Int
    let isMine: Bool
    let sentAt: String
    
    init(user: ChattingUserLocal, message: String, roomID: Int, isMine: Bool, sentAt: String) {
        self.user = user
        self.message = message
        self.roomID = roomID
        self.isMine = isMine
        self.sentAt = sentAt
    }
}

struct ChattingUserLocal {
    let userID: Int
    let userName: String
    let profileImageURL: String
    
    init(userID: Int, userName: String, profileImageURL: String) {
        self.userID = userID
        self.userName = userName
        self.profileImageURL = profileImageURL
    }
}
/*
 {
     "page" : 1,
     "chat_list" : [
         {
             "user" : {
                 "user_id" : 1,
                 "user_name" : "김은빈",
                 "profile_image_url" : "http://"
             },
             "message" : "안녕하세요?",
             "sent_at" : "오전 11:47"
         },
         {
             "user" : {
                 "user_id" : 2,
                 "user_name" : "김금빈",
                 "profile_image_url" : "http://"
             },
             "message" : "안녕하세요!",
             "sent_at" : "오전 11:48"
         },
     ]
 }
 */
