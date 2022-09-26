import Foundation
import Moya

class TagViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var tagValues: [Tags] = []
    
    func GstTagDatas() {
        postClient.request(.getTag) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(TagListModel.self, from: result.data) {
                        self.tagValues = data.tags.map {
                            let name = $0.name
                            let link = $0.image_url
                            
                            return Tags(name: name, image_url: link)
                        }
                    } else {
                        print("⚠️tag Error handling")
                    }
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️tag error: \(err.localizedDescription)")
            }
        }
    }
}
