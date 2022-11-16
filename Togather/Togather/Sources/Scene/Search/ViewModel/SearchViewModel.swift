import Foundation
import Moya
import SwiftUI

class SearchViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    @Published var postList: [Posts] = []
    @Published var title: String = ""
    @Published var tag: String = ""
    @Published var tagList: [Tags] = []
    func postTitle() {
        postClient.request(.getTitlePosts(title: title)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(UserPostModel.self, from: result.data) {
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
    func postTag() {
        self.tag = self.tag.uppercased()
        self.tag = self.tag.replacingOccurrences(of: ".", with: "_")
        print("태그:", self.tag)
        postClient.request(.getTagPosts(tag: tag)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(UserPostModel.self, from: result.data) {
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
