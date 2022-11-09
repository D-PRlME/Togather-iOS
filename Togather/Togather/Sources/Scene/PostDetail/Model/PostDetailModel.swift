import Foundation

struct PostsDetail {
    var title: String
    let user: Users
    let createdAt: String
    let tags: [Tags]
    let isMine: Bool
    var content: String
    var likeCount: Int
    var isLiked: Bool
    init(
        title: String,
        user: Users,
        createdAt: String,
        tags: [Tags],
        isMine: Bool,
        content: String,
        likeCount: Int,
        isLiked: Bool
    ) {
        self.title = title
        self.user = user
        self.createdAt = createdAt
        self.tags = tags
        self.isMine = isMine
        self.content = content
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
}

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    enum CodingKeys: String, CodingKey {
        case title, user, tags, content
        case createdAt = "created_at"
        case isMine = "is_mine"
        case isLiked = "is_liked"
        case likeCount = "like_count"
    } 
    let title, createdAt: String
    let user: User
    let tags: [Tag]
    let isMine, isLiked: Bool
    let content: String
    let likeCount: Int
}

/*
 {
     "post_id" : 1,
     "title" : "백엔드 모집합니다",
     "user_name" : "홍길동",
     "user_profile_image" : "https://~~~~"
     "created_at" : "2022-08-27T12:12:12",
     "tag" : [
         {
             "name" : "spring boot",
             "image_url" : "https://~~~"
         },
         {
             "name" : "javascript",
             "image_url" : "https://~~~"
         },
     ],
     "content" : "같이 프로젝트 하실 백엔드 구합니다 여기로 연락주세요"
 }*/
