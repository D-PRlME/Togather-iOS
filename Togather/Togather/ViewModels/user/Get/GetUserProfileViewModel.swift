import Foundation
import Moya

class GetUserProfileViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>()
    
    @Published var userID: String = ""
    @Published var userEmail: String = ""
    @Published var userProfilImageLink: String = ""
    
    func signUpClient() {
        UserClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(UserProfileModel.self, from: result.data) {
                        self.userID = data.account_id
//                        self.userEmail = data.email
                        self.userProfilImageLink = data.profile_image_url
                    } else {
                        print("⚠️getUserProfile docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
                    } else {
                        print("⚠️getUserProfile Error decode")
                    }
                }
                
            case .failure(let err):
                print("⛔️getUserProfile Error: \(err.localizedDescription)")
            }
        }
    }
}
