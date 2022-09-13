import Foundation

// MARK: - SearchPostModelElement (게시글 검색)
struct SearchPostModelElement: Codable {
    let title: String
    let userName: String
    let tags: [String]
    let createAt: String
}

typealias SearchPostModel = [SearchPostModelElement]

/*
[
    {
        "title" : "프로젝트 백엔드 모집합니다",
        "userName" : "김성원",
        "tags" : ["BACKEND", "SPRING"],
        "createAt":"몇시몇분몇초"
    },
    {
        "title":"프로젝트 백엔드 모집합니다",
        "userName":"김성원",
        "tags":["BACKEND", "SPRING"],
        "createAt":"몇시몇분몇초"
    }
]
 */
