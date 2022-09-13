import Foundation

// MARK: - LookUpPostModel (내 게시글, 전체 게시글 목록)
struct LookUpPostModel: Codable {
    let post_list: [PostList]
    let totalPages: Int
    let last: Bool
    let first: Bool
}

// MARK: - PostList
struct PostList: Codable {
    let post_id: Int
    let title: String
    let user_name: String
    let tag: [String]
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
    "first": true //첫번째 페이지 여부
}
*/
