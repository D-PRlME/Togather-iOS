import Foundation

import Moya

enum ImageClient {
    case postImage(_ image: Data)
}

extension ImageClient: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.35.113.190:8080/images")!
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
        case .postImage(let image):
            var multiformData = [MultipartFormData]()
            multiformData.append(.init(
                provider: .data(image),
                name: "image",
                fileName: ".jpg",
                mimeType: "/jpg"
            ))
            return .uploadMultipart(multiformData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postImage:
            return Header.accessToken.header()
        }
    }
}
