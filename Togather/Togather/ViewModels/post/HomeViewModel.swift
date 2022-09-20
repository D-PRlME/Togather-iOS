import Foundation
import Moya

class HomeViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    @Published var postList: [Posts] = []
    
    @Published var post_id: [Int] = []
    @Published var tagList: [Tags] = []
    
    func post() {
        postClient.request(.getPosts) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(UserPostModel.self, from: result.data) {
                        
//                        let post_id: Int
//                        let title: String
//                        let users: Users
//                        let tags: [Tags]
//                        let created_at: String
                        
                        self.postList = data.post_list.map { index in
                            let postID = index.post_id
                            let title = index.title
                            let users: Users = Users(user_id: index.user.user_id, user_name: index.user.user_name, profile_image_url: index.user.profile_image_url)
                            let createdAt = index.created_at
                            let tags: [Tags] = index.tags.map {
                                let name = $0.name
                                let imageURL = $0.image_url
                                
                                return Tags(name: name, image_url: imageURL)
                            }
                            
                            return Posts(
                                post_id: postID,
                                title: title,
                                users: users,
                                tags: tags,
                                created_at: createdAt
                            )
                        }
                    } else {
                        print("⚠️post docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️Appear post Error handling")
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

