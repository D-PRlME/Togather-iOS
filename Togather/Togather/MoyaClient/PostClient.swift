import Foundation
import Moya

enum PostService {
    case post(title: String, content: String, tag: [String], link: String)
    case editPost(title: String, content: String, tag: [String], link: String, postID: Int)
    case getMyPosts
    case getPosts
    case getTitlePosts(title: String)
    case getTagPosts(tag: String)
    case getDetailPosts(postID: Int)
    case deletePost(postID: Int)
    case getTag
    case like(postID: Int)
    case dislike(postID: Int)
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
            return "/tag/list"
        case .getTitlePosts:
            return "/title"
        case .getTagPosts:
            return "/tag"
        case .like(let postID), .dislike(let postID):
            return "/like/\(postID)"
        }
    }
    var method: Moya.Method {
        switch self {
            
        case .post, .like :
            return .post
        case .getMyPosts, .getPosts, .getDetailPosts, .getTag, .getTitlePosts, .getTagPosts:
            return .get
        case .editPost:
            return .patch
        case .deletePost, .dislike:
            return .delete
        }
    }
    
    
    var task: Task {
        switch self {
            
        case .post(let title, let content, let tags, let link):
            return .requestParameters(
                parameters:
                    [
                        "title": title,
                        "tags": tags,
                        "content": content,
                        "link": link
                    ],
                encoding: JSONEncoding.default)
            
        case .editPost(let title, let content, let tags, let link, _):
            return .requestParameters(
                parameters:
                    [
                        "title": title,
                        "tags": tags,
                        "content": content,
                        "link": link
                    ],
                encoding: JSONEncoding.default)
            
        case .getTitlePosts(title: let title):
            return .requestParameters(
                parameters:
                    [
                        "title" : title,
                        "sort" : "id,desc"
                    ],
                encoding: URLEncoding.queryString)
        case .getTagPosts(tag: let tag):
            return .requestParameters(
                parameters:
                    [
                        "tag" : tag,
                        "sort" : "id,desc"
                    ],
                encoding: URLEncoding.queryString)
        case .getPosts, .getMyPosts:
            return .requestParameters(
                parameters:
                    [
                        "sort" : "id,desc"
                    ],
                encoding: URLEncoding.queryString)
            
        case .getDetailPosts, .deletePost, .getTag, .like, .dislike:
            return .requestPlain
        }
    }
    
    
    var headers: [String : String]? {
        switch self {
        case .getMyPosts, .getPosts, .getDetailPosts, .post, .editPost, .deletePost, .getTag, .getTitlePosts, .getTagPosts, .like, .dislike:
            return Header.accessToken.header()
        }
    }
}
