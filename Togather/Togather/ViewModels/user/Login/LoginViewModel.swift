import Foundation
import Moya

class LoginViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var viewTag: Int? = nil
    @Published var showProgrees: Bool = false
    
    func Login() {
        userClient.request(.login(accountID: email, password: password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                            Token.accessToken = data.access_token
                            Token.refreshToken = data.refresh_token
                            self.getMyProFile()
                            print("✅로그인 성공")
                            print("🔊\(data.expired_at)")
                            self.viewTag = 1
                        } else {
                            print("⚠️login docoder error")
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showProgrees = false
                    }
                default:
                    print("\(result.statusCode)")
                    self.showProgrees = false
                }
            case .failure(let err):
                print("⛔️login error: \(err.localizedDescription)")
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
                        Account.setAccount(
                            id: data.name,
                            email: data.email,
                            profileImagLink: data.profile_image_url,
                            positions: data.positions
                        )
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
