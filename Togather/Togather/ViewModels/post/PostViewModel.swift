import Foundation
import Moya

class PostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>()
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var tag: [String] = []
    @Published var link: String = ""
    
    func post() {
        postClient.request(.post(title: title, content: content, tag: tag, link: link)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    print("게시물 올리기 성공")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️post error")
                    }
                }
            case .failure(let err):
                print("emailDupilcate error: \(err.localizedDescription)")
            }
        }
    }
    
}
