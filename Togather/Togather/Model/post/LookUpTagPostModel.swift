import Foundation

// MARK: - LookUpTagPostModel (태그 게시글 목록 조회)
struct LookUpTagPostModel: Codable {
    let title: String
    let userName: String
    let tags: [String]
    let createAt: String
}

/*
{
        "title":"프로젝트 백엔드 모집합니다",
        "userName":"김성원",
        "tags":[
            "BACKEND",
            "SPRING"
        ],
        "createAt":"몇시몇분몇초"
}
*/
