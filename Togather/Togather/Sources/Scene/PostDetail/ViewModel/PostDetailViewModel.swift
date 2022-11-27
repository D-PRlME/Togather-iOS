import Foundation
import Moya

class PostDetailViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    let chatClient = MoyaProvider<ChatService>(plugins: [MoyaLoggerPlugin()])
    @Published var showSkeleton = true
    @Published var postID: Int = 0
    @Published var tagName: [String] = []
    @Published var postDetail: PostsDetail = PostsDetail(
        title: DumyData.title,
        user: Users(userID: 0, userName: DumyData.name, profileImageUrl: ""),
        createdAt: DumyData.time,
        tags: [],
        isMine: false,
        content: DumyData.content,
        likeCount: 0,
        isLiked: false
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
                                userID: data.user.userID,
                                userName: data.user.userName,
                                profileImageUrl: data.user.profileImageUrl
                            )
                            let createdAt = data.createdAt
                            let tags: [Tags] = data.tags.map {
                                let name = $0.name
                                let imageURL = $0.imageUrl
                                return Tags(
                                    name: name,
                                    imageUrl: imageURL
                                )
                            }
                            let isMine = data.isMine
                            let content = data.content
                            let likeCount = data.likeCount
                            let isLiked = data.isLiked
                            self.postDetail = PostsDetail(
                                title: title,
                                user: users,
                                createdAt: createdAt,
                                tags: tags,
                                isMine: isMine,
                                content: content,
                                likeCount: likeCount,
                                isLiked: isLiked
                            )
                            self.tagName = tags.map { $0.name }
                        } else { print("⚠️post detail docoder error") }
                        self.showSkeleton = false
                    }
                default: print(result.statusCode)
                }
            case .failure(let err): print("⛔️post error: \(err.localizedDescription)")
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
    func linkUser() {
        chatClient.request(.creatIndividualChat(userID: postDetail.user.userID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 201:
                    print("\(self.postDetail.user.userName)님과의 채팅방이 생성되었습니다!")
                case 409:
                    print("\(self.postDetail.user.userName)님과의 채팅방이 이미 존재합니다!")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️creat chatting room error: \(err.localizedDescription)")
            }
        }
    }
}
