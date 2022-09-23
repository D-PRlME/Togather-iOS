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
            print("editTag: \(tag)")
        }
        postClient.request(.editPost(title: title, content: content, tag: tag, link: link, postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("수정 성공!")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️edit Appear post Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}


