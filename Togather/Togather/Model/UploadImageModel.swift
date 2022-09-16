import Foundation

// MARK: - UploadImageModel (사진 업로드)
struct UploadImageModel: Codable {
    let image_url: [String]
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
