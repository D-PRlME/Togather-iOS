import Foundation

struct Posts_Detail {
    let post_id: Int
    let title: String
    let user_name: String
    let user_profile_image: String
    let created_at: String
    let tags: [Tags]
    let content: String
    
    init(
        post_id: Int,
        title: String,
        user_name: String,
        user_profile_image: String,
        created_at: String,
        tags: [Tags],
        content: String
    ){
        self.post_id = post_id
        self.title = title
        self.user_name = user_name
        self.user_profile_image = user_profile_image
        self.created_at = created_at
        self.tags = tags
        self.content = content
    }
}

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    let post_id: Int
    let title, user_name: String
    let user_profile_image: String
    let created_at: String
    let tag: [Tag]
    let content: String
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
