import Foundation
import Moya
import SwiftUI

class MyPostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    @Published var postList: [Posts] = []
    func post() {
        postClient.request(.getMyPosts) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(MyViewUserPostModel.self, from: result.data) {
                            self.postList = data.postList.map { index in
                                let postID = index.postID
                                let title = index.title
                                let users: Users = Users(userID: index.user.userID, userName: index.user.userName, profileImageUrl: index.user.profileImageUrl)
                                let createdAt = index.createdAt
                                let tags: [Tags] = index.tags.map {
                                    let name = $0.name
                                    let imageURL = $0.imageUrl
                                    return Tags(name: name, imageUrl: imageURL)
                                }
                                let likeCount = index.likeCount
                                return Posts(
                                    postID: postID,
                                    title: title,
                                    users: users,
                                    tags: tags,
                                    createdAt: createdAt,
                                    likeCount: likeCount
                                )
                            }
                        } else {
                            print("⚠️post docoder error")
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
