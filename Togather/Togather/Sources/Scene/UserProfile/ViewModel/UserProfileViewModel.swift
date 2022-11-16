import Foundation
import Moya

class UserProfileViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var userID: Int = 0
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var userProfileImageURL: String = ""
    @Published var userIntroduce: String = ""
    @Published var userPositions: [String] = []
    func getUserProfile() {
        userClient.request(.getUserProfile(userID: userID)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(UserProfileModel.self, from: result.data) {
                        self.userName = data.name
                        self.userEmail = data.email
                        self.userProfileImageURL = data.profileImageUrl
                        self.userIntroduce = data.introduce
                        self.userPositions = data.positions
                    } else {
                        print("⚠️getUserProfile docoder error")
                    }
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️getUserProfile Error: \(err.localizedDescription)")
            }
        }
    }
}
