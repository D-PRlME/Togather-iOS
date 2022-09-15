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
