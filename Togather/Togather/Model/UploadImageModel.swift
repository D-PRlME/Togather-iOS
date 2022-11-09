import Foundation

// MARK: - UploadImageModel (사진 업로드)
struct UploadImageModel: Codable {
    enum CodingKeys: String, CodingKey {
        case imagesUrl = "images_url"
    }
    let imagesUrl: [String]
}

/*
{
    "image_url" : [
        "https://~~~~~~~~~~~",
        "https://~~~~~~~~~~~",
        "https://~~~~~~~~~~~"
    ]
}
*/
