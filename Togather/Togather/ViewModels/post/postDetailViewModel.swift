import Foundation
import Moya

class PostDetailViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>()
    
    @Published var postID: Int = 0
    @Published var postDetail: Posts_Detail = Posts_Detail(
        post_id: 0,
        title: "",
        user_name: "",
        user_profile_image: "",
        created_at: "",
        tags: [
            Tags(name: "", image_url: "")
            ],
        content: ""
    )
    
    func getPostDetail() {
        postClient.request(.getDetailPosts(postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(PostDetailModel.self, from: result.data) {
                        
                        let postID = data.post_id
                        let title = data.title
                        let userName = data.user_name
                        let userProfileImage = data.user_profile_image
                        let createdAt = data.created_at
                        let tags: [Tags] = data.tag.map {
                            let name = $0.name
                            let imageURL = $0.image_url
                            
                            return Tags(name: name, image_url: imageURL)
                        }
                        let content = data.content
                        
                        self.postDetail = Posts_Detail(
                            post_id: postID,
                            title: title,
                            user_name: userName,
                            user_profile_image: userProfileImage,
                            created_at: createdAt,
                            tags: tags,
                            content: content
                        )
                        
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

