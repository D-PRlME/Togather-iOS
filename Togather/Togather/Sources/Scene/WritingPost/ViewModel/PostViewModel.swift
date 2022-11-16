import Foundation
import Moya
import SwiftUI

class PostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var tag: [String] = []
    @Published var tagList: [Tag] = []
    @Published var tagListName: [String] = []
    func post() {
        for index in 0..<self.tag.count {
            self.tag[index] = self.tag[index].uppercased()
            self.tag[index] = self.tag[index].replacingOccurrences(of: ".", with: "_")
        }
        postClient.request(.post(title: title, content: content, tag: tag)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("게시물 올리기 성공")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}
