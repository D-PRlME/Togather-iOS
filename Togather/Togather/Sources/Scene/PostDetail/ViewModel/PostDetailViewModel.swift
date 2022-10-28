import Foundation
import Moya

class PostDetailViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var showSkeleton = true
    @Published var postID: Int = 0
    @Published var tagName: [String] = []
    @Published var postDetail: Posts_Detail = Posts_Detail(
        title: DumyData.title,
        user: Users(user_id: 0, user_name: DumyData.name, profile_image_url: ""),
        created_at: DumyData.time,
        tags: [],
        is_mine: false,
        content: DumyData.content,
        link: "",
        like_count: 0,
        is_liked: false
    )
    
    func getPostDetail() {
        
        postClient.request(.getDetailPosts(postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(PostDetailModel.self, from: result.data) {
                            let title = data.title
                            let users: Users = Users(
                                user_id: data.user.user_id,
                                user_name: data.user.user_name,
                                profile_image_url: data.user.profile_image_url
                            )
                            let createdAt = data.created_at
                            let tags: [Tags] = data.tags.map {
                                let name = $0.name
                                let imageURL = $0.image_url
                                
                                return Tags(
                                    name: name,
                                    image_url: imageURL
                                )
                            }
                            let is_mine = data.is_mine
                            let content = data.content
                            let link = data.link
                            let like_count = data.like_count
                            let is_liked = data.is_liked
                            
                            self.postDetail = Posts_Detail(
                                title: title,
                                user: users,
                                created_at: createdAt,
                                tags: tags,
                                is_mine: is_mine,
                                content: content,
                                link: link,
                                like_count: like_count,
                                is_liked: is_liked
                            )
                            self.tagName = tags.map {
                                $0.name
                            }
                            
                        } else {
                            print("⚠️post detail docoder error")
                        }
                        self.showSkeleton = false
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
    
    func like() {
        postClient.request(.like(postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("좋아요 성공!")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
    
    func dislike() {
        postClient.request(.dislike(postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("좋아요 취소 성공!")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
    
    func delete() {
        postClient.request(.deletePost(postID: postID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("삭제 성공!")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}

