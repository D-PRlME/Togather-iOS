import Foundation

// MARK: - ChatListModel
struct ChatListModel: Codable {
    let roomList: [RoomList]

    enum CodingKeys: String, CodingKey {
        case roomList = "room_list"
    }
}

// MARK: - RoomList
struct RoomList: Codable {
    let roomID: Int
    let roomName: String
    let roomLogoImage: String
    let roomType: String
    let isRead: Bool
    let lastChat: LastChat

    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case roomName = "room_name"
        case roomLogoImage = "room_logo_image"
        case roomType = "room_type"
        case isRead = "is_read"
        case lastChat = "last_chat"
    }
}

// MARK: - LastChat
struct LastChat: Codable {
    let lastMessage, lastSentAt: String

    enum CodingKeys: String, CodingKey {
        case lastMessage = "last_message"
        case lastSentAt = "last_sent_at"
    }
}

struct ChattingRoomList {
    let roomID: Int
    let roomType, roomLogoImage, roomName: String
    let lastChat: LastChatting
    let isRead: Bool
    init(
        roomID: Int,
        roomType: String,
        roomLogoImage: String,
        roomName: String,
        lastChat: LastChatting,
        isRead: Bool
    ) {
        self.roomID = roomID
        self.roomType = roomType
        self.roomLogoImage = roomLogoImage
        self.roomName = roomName
        self.lastChat = lastChat
        self.isRead = isRead
    }
}

struct LastChatting {
    let lastMessage, lastSentAt: String
}
/*
{
 "room_list":[
 {"room_id":1,
 "room_name":"알 수 없는 유저",
 "room_logo_image":"https://wouldyou1214.s3.amazonaws.com/DefaultUser.png",
 "room_type":"PRIVATE","is_read":true,
 "last_chat":{
 "last_message":"",
 "last_sent_at":"1달전"}},
 {
 "room_id":2,
 "room_name":"병진",
 "room_logo_image":"https://wouldyou1214.s3.amazonaws.com/DefaultUser.png",
 "room_type":"PRIVATE",
 "is_read":true,
 "last_chat":{
 "last_message":"",
 "last_sent_at":"1달전"}
 
 }]}
*/
