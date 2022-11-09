import Foundation

import Moya

enum ImageClient {
    case postImage(_ images: [Data])
}

extension ImageClient: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.55.240.35:8080/images")!
    }
    
    var path: String {
        switch self {
        case .postImage:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postImage:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postImage(let images):
            var multiformData = [MultipartFormData]()
            for image in images {
                multiformData.append(.init(
                    provider: .data(image),
                    name: "images",
                    fileName: "images.jpg",
                    mimeType: "images/jpg"
                ))
            }
            return .uploadMultipart(multiformData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .postImage:
            return Header.accessToken.header()
        }
    }
}
