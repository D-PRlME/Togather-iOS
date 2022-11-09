import Foundation

// MARK: - TagListModel
struct TagListModel: Codable {
    let tags: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
    let name: String
    let imageUrl: String
}

/*
 "tag" : [
         {
             "name" : "spring boot",
             "image_url" : "https://~~~"
         },
         {
             "name" : "javascript",
             "image_url" : "https://~~~"
         }
 */
