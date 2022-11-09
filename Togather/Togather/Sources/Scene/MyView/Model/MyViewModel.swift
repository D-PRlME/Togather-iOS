import Foundation

// MARK: - UserPostModel
struct MyViewUserPostModel: Codable {
    enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
    let postList: [PostList]
}
