import Foundation

// MARK: - UserPostModel
struct UserPostModel: Codable {
    enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
    let postList: [PostList]
}

// MARK: - PostList
struct PostList: Codable {
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, user, tags
        case createdAt = "created_at"
        case likeCount = "like_count"
    }
    let postID: Int
    let title: String
    let user: User
    let tags: [Tag]
    let createdAt: String
    let likeCount: Int
}
// MARK: - User
struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case profileImageUrl = "profile_image_url"
    }
    let userID: Int
    let userName: String
    let profileImageUrl: String
}

struct Posts {
    let postID: Int
    let title: String
    let users: Users
    let tags: [Tags]
    let createdAt: String
    let likeCount: Int
    
    init(
        postID: Int,
        title: String,
        users: Users,
        tags: [Tags],
        createdAt: String,
        likeCount: Int
    ) {
        self.postID = postID
        self.title = title
        self.users = users
        self.createdAt = createdAt
        self.tags = tags
        self.likeCount = likeCount
    }
}

struct Tags: Hashable {
    let name: String
    let imageUrl: String
}

struct Users {
    let userID: Int
    let userName: String
    let profileImageUrl: String
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
