import Foundation

struct Posts_Detail {
    let title: String
    let user: Users
    let created_at: String
    let tags: [Tags]
    let content: String
    let link: String
    
    init(
        title: String,
        user: Users,
        created_at: String,
        tags: [Tags],
        content: String,
        link: String
    ){
        self.title = title
        self.user = user
        self.created_at = created_at
        self.tags = tags
        self.content = content
        self.link = link
    }
}

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    let title, created_at: String
    let user: User
    let tags: [Tag]
    let content, link: String
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
