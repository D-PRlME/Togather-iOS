import Foundation
import Moya
import SwiftUI

class PostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var tag: [String] = []
    @Published var link: String = ""
    
    @Published var tagList: [Tag] = []
    @Published var tagListName: [String] = []
    
    func post() {
        for i in 0..<self.tag.count {
            self.tag[i] = self.tag[i].uppercased()
            self.tag[i] = self.tag[i].replacingOccurrences(of: ".", with: "_")
        }
        postClient.request(.post(title: title, content: content, tag: tag, link: link)) { res in
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
    func GetTagList() {
        postClient.request(.getTag) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(TagListModel.self, from: result.data) {
                            self.tagList = data.tags
                            for i in 0..<self.tagList.count {
                                self.tagListName.append(self.tagList[i].name)
                            }
                        } else {
                            print("⚠️login docoder error")
                        }
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}
