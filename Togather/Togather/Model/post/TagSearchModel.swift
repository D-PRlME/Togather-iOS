import Foundation

// MARK: - TagSearchModel
struct TagSearchModel: Codable {
    let postList: [PostList]

    enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
}
