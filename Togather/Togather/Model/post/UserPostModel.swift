// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userPostModel = try? newJSONDecoder().decode(UserPostModel.self, from: jsonData)

import Foundation

// MARK: - UserPostModel
struct UserPostModel: Codable {
    let post_list: [PostList]
}

// MARK: - PostList
struct PostList: Codable {
    let post_id: Int
    let title: String
    let user: User
    let tags: [Tag]
    let created_at: String
}
// MARK: - User
struct User: Codable {
    let user_id: Int
    let user_name: String
    let profile_image_url: String
}

//
struct Posts {
    let post_id: Int
    let title: String
    let users: Users
    let tags: [Tags]
    let created_at: String
    
    init(
        post_id: Int,
        title: String,
        users: Users,
        tags: [Tags],
        created_at: String
    ){
        self.post_id = post_id
        self.title = title
        self.users = users
        self.created_at = created_at
        self.tags = tags
    }
}

struct Tags: Hashable {
    var name: String
    let image_url: String
}

struct Users {
    let user_id: Int
    let user_name: String
    let profile_image_url: String
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
