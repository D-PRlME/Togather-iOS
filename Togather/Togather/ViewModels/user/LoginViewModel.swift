import Foundation
import Moya

class LoginViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var viewTag: Int? = nil
    
    func Login() {
        userClient.request(.login(accountID: email, password: password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                        
                        Token.accessToken = data.access_token
                        Token.refreshToken = data.refresh_token
                        
                        print("✅로그인 성공")
                        print("🔊\(data.expired_at)")
                        self.viewTag = 1
                    } else {
                        print("⚠️login docoder error")
                    }
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️login error: \(err.localizedDescription)")
            }
        }
    }
}
