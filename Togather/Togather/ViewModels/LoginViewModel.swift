import Foundation
import Moya

class LoginViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>()
    
    @Published var email: String = ""
    @Published var password: String = ""
    
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
                    } else {
                        print("⚠️login docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️login Error handling")
                    }
                }
            case .failure(let err):
                print("login error: \(err.localizedDescription)")
            }
        }
    }
}
