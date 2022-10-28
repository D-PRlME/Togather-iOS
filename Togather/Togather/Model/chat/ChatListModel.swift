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
    let message, sent_at: String
}
