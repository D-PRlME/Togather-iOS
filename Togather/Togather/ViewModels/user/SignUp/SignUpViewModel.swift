import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSuccess: Int?
    
    func signUpClient() {
        userClient.request(.signup(password: password, email: email, name: name)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                        Token.accessToken = data.access_token
                        Token.refreshToken = data.refresh_token
                        self.isSuccess = 1
                        self.getMyProFile()
                        print("🔊\(data.expired_at)")
                    } else {
                        print("⚠️signup docoder error")
                    }
                default:
                    print(result.statusCode)
                }
                
            case .failure(let err):
                print("⛔️signup Error: \(err.localizedDescription)")
            }
        }
    }
    
    func getMyProFile() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(MyProfileModel.self, from: result.data) {
                        Account.ID = data.name
                        Account.email = data.email
                        Account.profileImagLink = data.profile_image_url
                    } else {
                        print("⚠️myProfile LG docoder error")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️myProfile LG Error: \(err.localizedDescription)")
            }
        }
    }
}
