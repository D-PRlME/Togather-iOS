import Foundation

// MARK: - ChatListModel
struct ChatListModel: Codable {
    let room_list: [RoomList]
}

// MARK: - RoomList
struct RoomList: Codable {
    let room_id: Int
    let room_type, room_logo_image, room_name: String
    let last_chat: LastChat
    let is_read: Bool
}

// MARK: - LastChat
struct LastChat: Codable {
    let last_message, last_sent_at: String
}

struct ChattingList {
    let room_id: Int
    let room_type, room_logo_image, room_name: String
    let last_chat: LastChatting
    let is_read: Bool
    init(
        room_id: Int,
        room_type: String,
        room_logo_image: String,
        room_name: String,
        last_chat: LastChatting,
        is_read: Bool
    ) {
        self.room_id = room_id
        self.room_type = room_type
        self.room_logo_image = room_logo_image
        self.room_name = room_name
        self.last_chat = last_chat
        self.is_read = is_read
    }
}

struct LastChatting {
    let last_message, last_sent_at: String
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
