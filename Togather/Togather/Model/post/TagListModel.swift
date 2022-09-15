import Foundation

// MARK: - TagListModel
struct TagListModel: Codable {
    let tags: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    let name: String
    let image_url: String
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
