import Foundation

// MARK: - UserPostModel (그냥 포스트랑 제목, 태그 검생 포함)
struct UserPostModel: Codable {
    let post_list: [PostList]
}

// MARK: - PostList
struct PostList: Codable {
    let post_id: Int
    let title, user_name: String
    let user_profile_image: String
    let created_at: String
    let tags: [Tag]
}

struct Posts {
    let post_id: Int
    let title: String
    let user_name: String
    let user_profile_image: String
    let created_at: String
    let tags : [Tags]
    
    init(
        post_id: Int,
        title: String,
        user_name: String,
        user_profile_image: String,
        created_at: String,
        tags: [Tags]
    ){
        self.post_id = post_id
        self.title = title
        self.user_name = user_name
        self.user_profile_image = user_profile_image
        self.created_at = created_at
        self.tags = tags
    }
}

struct Tags: Hashable {
    let name: String
    let image_url: String
}

/*
 {
     "post_list" : [
         {
             "post_id" : 1,
             "title" : "백엔드 모집합니다",
             "user_name" : "홍길동",
             "user_profile_image" : "https://~~~~",
             "created_at" : "2022-08-27T12:12:12"
             "tags" : [
                 {
                     "name" : "spring boot",
                     "image_url" : "https://~~~"
                 }
             ]
         },
         {
             "post_id" : 2,
             "title" : "프론트 모집합니다",
             "user_name" : "홍길동",
             "user_profile_image" : "https://~~~~",
             "created_at" : "2022-08-27T12:12:12"
             "tags" : [
                 {
                     "name" : "React",
                     "image_url" : "https://~~~"
                 }
             ]
         }
     ]
 }
 */
