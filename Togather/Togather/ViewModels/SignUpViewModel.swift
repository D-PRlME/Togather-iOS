import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>()
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    
    func signUpClient() {
        UserClient.request(.signup(password: password, email: email, name: name)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                        Token.accessToken = data.access_token
                        Token.refreshToken = data.refresh_token
                        print("🔊\(data.expired_at)")
                    } else {
                        print("⚠️signup docoder error")
                    }
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️Error decode")
                    }
                }
                
            case .failure(let err):
                print("⚠️signup Error: \(err.localizedDescription)")
            }
        }
    }
}
