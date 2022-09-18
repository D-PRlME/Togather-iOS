import Foundation
import Moya

class HomeViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    @Published var postList: [Posts] = []
    
    @Published var post_id: [Int] = []
//    @Published var title: [String] = []
//    @Published var user_name: [String] = []
//    @Published var user_profile_image: [String] = []
//    @Published var created_at: [String] = []
//    @Published var tags: [Tags] = []
    
    @Published var tagList: [Tags] = []
    
    func post() {
        postClient.request(.getPosts) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(UserPostModel.self, from: result.data) {
                        
                        self.postList = data.post_list.map { index in
                            let postID = index.post_id
                            let title = index.title
                            let userName = index.user_name
                            let userProfileImage = index.user_profile_image
                            let createdAt = index.created_at
                            let tags: [Tags] = index.tags.map {
                                let name = $0.name
                                let imageURL = $0.image_url
                                
                                return Tags(name: name, image_url: imageURL)
                            }
                            
                            return Posts(
                                post_id: postID,
                                title: title,
                                user_name: userName,
                                user_profile_image: userProfileImage,
                                created_at: createdAt,
                                tags: tags
                            )
                        }
                    } else {
                        print("⚠️login docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️post Error handling")
                    }
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
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(TagListModel.self, from: result.data) {
                        
                        self.tagList = data.tags.map { index in
                            let name = index.name
                            let imageURL = index.image_url
                            
                            return Tags(name: name, image_url: imageURL)
                        }
                    } else {
                        print("⚠️login docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️post Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}

