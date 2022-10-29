import Foundation
import Moya
import SwiftUI

class EditPostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var tag: [String] = []
    @Published var link: String = ""
    @Published var postID: Int = 0
    
    func edit() {
        for i in 0..<tag.count {
            self.tag[i] = self.tag[i].uppercased()
            self.tag[i] = self.tag[i].replacingOccurrences(of: ".", with: "_")
        }
        postClient.request(.editPost(title: title, content: content, tag: tag, postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("수정 성공!📝")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}


