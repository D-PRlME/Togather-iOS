import Foundation

// MARK: - MyPostModel
struct MyPostModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
    let postList: [MyPostList]
}

// MARK: - PostList
struct MyPostList: Codable {
    private enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, user, tags
        case createdAt = "created_at"
        case isComplete = "is_complete"
        case likeCount = "like_count"
    }
    let postID: Int
    let title: String
    let user: User
    let createdAt: String
    let tags: [Tag]
    let isComplete: Bool
    let likeCount: Int
}
/*
 {
     "post_list" : [
         {
             "post_id" : 1,
             "title" : "백엔드 모집합니다",
             "user_name" : "홍길동",
             "tag" : [
                 "BACKEND",
                 "NODE_JS"
             ]
         },
         {
             "post_id" : 2,
             "title" : "프론트 모집합니다",
             "user_name" : "홍길동",
             "tag" : [
                 "FRONTEND",
                 "REACT"
             ]
         }
     ],
     "totalPages": 20, //총 페이지 수
     "last": false, //마지막 페이지 여부
   "first": true  //첫번째 페이지 여부
 }
 */
