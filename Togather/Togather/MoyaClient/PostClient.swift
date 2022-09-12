import Foundation
import Moya

enum PostService {
    case post(title: String, content: String, tag: [String], link: String)
    case editPost(title: String, content: String, tag: [String], link: String, postID: Int)
    case getMyPosts(page: Int, size: Int, sort: String)
    case getPosts(page: Int, size: Int, sort: String)
    case getDetailPosts(postID: Int)
    case deletePost(postID: Int)
    case getTag
}

extension PostService: TargetType {
    var baseURL: URL {
        return URL(string: "http://44.209.75.36:8080/posts")!
    }
    
    var path: String {
        switch self {
            
        case .post:
            return ""
        case .editPost(_, _, _, _, let postID):
            return "/\(postID)"
        case .getMyPosts:
            return "/my"
        case .getPosts:
            return ""
        case .getDetailPosts(let postID):
            return "/\(postID)"
        case .deletePost(let postID):
            return "/\(postID)"
        case .getTag:
            return "/tag"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .post:
            return .post
        case .getMyPosts, .getPosts, .getDetailPosts, .getTag:
            return .get
        case .editPost:
            return .patch
        case .deletePost:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
            
        case .post(let title, let content, let tags, _):
            return .requestJSONEncodable(["title" : title, "tag" : "\(tags)", "content" : content])
        case .editPost(let title, let content, let tags, _, _):
            return .requestJSONEncodable(["title" : title, "tag" : "\(tags)", "content" : content])
        case .getMyPosts(let page, let size, let sort):
            return .requestParameters(parameters: ["page" : page, "size" : size, "sort" : sort], encoding: URLEncoding.queryString)
        case .getPosts(let page, let size, let sort):
            return .requestParameters(parameters: ["page" : page, "size" : size, "sort" : sort], encoding: URLEncoding.queryString)
        case .getDetailPosts, .deletePost, .getTag:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .post, .editPost, .deletePost, .getTag:
            return Header.tokenIsEmpty.header()
        case .getMyPosts, .getPosts, .getDetailPosts:
            return Header.accessToken.header()
        }
    }
}
