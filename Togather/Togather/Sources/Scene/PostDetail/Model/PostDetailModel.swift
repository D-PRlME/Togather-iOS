import Foundation

struct Posts_Detail {
    var title: String
    let user: Users
    let created_at: String
    let tags: [Tags]
    let is_mine: Bool
    var content: String
    var like_count: Int
    var is_liked: Bool
    
    
    init(
        title: String,
        user: Users,
        created_at: String,
        tags: [Tags],
        is_mine: Bool,
        content: String,
        like_count: Int,
        is_liked: Bool
    ){
        self.title = title
        self.user = user
        self.created_at = created_at
        self.tags = tags
        self.is_mine = is_mine
        self.content = content
        self.like_count = like_count
        self.is_liked = is_liked
    }
}

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    let title, created_at: String
    let user: User
    let tags: [Tag]
    let is_mine, is_liked: Bool
    let content: String
    let like_count: Int
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
