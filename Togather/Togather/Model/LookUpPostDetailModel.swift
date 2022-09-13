import Foundation

// MARK: - LookUpPostDetailModel (게시글 상세 조회)
struct LookUpPostDetailModel: Codable {
    let post_id: Int
    let title: String
    let user_name: String
    let created_at: String
    let tag: [String]
    let content: String
}

/*
{
    "post_id" : 1,
    "title" : "백엔드 모집합니다",
    "user_name" : "홍길동",
    "created_at" : "2022-08-27T12:12:12",
    "tag" : [
        "BACKEND",
        "NODE_JS"
    ],
    "content" : "같이 프로젝트 하실 백엔드 구합니다 여기로 연락주세요"
}
*/
