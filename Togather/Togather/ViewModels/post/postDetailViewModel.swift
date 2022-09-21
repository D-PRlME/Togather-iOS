import Foundation
import Moya

class PostDetailViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>()
    
    @Published var postID: CLong = 0
    @Published var tagName: [String] = []
    @Published var postDetail: Posts_Detail = Posts_Detail(
        title: "",
        user: Users(user_id: 0, user_name: "", profile_image_url: ""),
        created_at: "",
        tags: [
            Tags(name: "", image_url: "")
        ],
        is_mine: false,
        content: "",
        link: ""
    )
    
    func getPostDetail() {

        postClient.request(.getDetailPosts(postID: postID)) { res in
            print("postDetail postID : \(self.postID)")
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(PostDetailModel.self, from: result.data) {
                        let title = data.title
                        let users: Users = Users(user_id: data.user.user_id, user_name: data.user.user_name, profile_image_url: data.user.profile_image_url)
                        let createdAt = data.created_at
                        let tags: [Tags] = data.tags.map {
                            let name = $0.name
                            let imageURL = $0.image_url
                            
                            return Tags(name: name, image_url: imageURL)
                        }
                        let is_mine = data.is_mine
                        let content = data.content
                        let link = data.link
                        
                        self.postDetail = Posts_Detail(
                            title: title,
                            user: users,
                            created_at: createdAt,
                            tags: tags,
                            is_mine: is_mine,
                            content: content,
                            link: link
                        )
                        print("게시물 상세 정보 : ", self.postDetail)
                        self.tagName = tags.map {
                            $0.name
                        }
                    } else {
                        print("⚠️post detail docoder error")
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

