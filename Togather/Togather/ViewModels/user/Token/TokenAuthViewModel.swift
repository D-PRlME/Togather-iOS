import Foundation
import Moya

class TokenAuthViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>()
    
    func TokenReissueClient() {
        UserClient.request(.tokenReissue) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                        Token.accessToken = data.access_token
                        Token.refreshToken = data.refresh_token
                        print("token 재발급")
                        print("🔊\(data.expired_at)")
                    } else {
                        print("⚠️tokenAuth docoder error")
                    }
                case 404:
                    print("알수없는 토큰")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
                    } else {
                        print("⚠️tokenAuth Error decode")
                    }
                }
                
            case .failure(let err):
                print("⛔️tokenAuth Error: \(err.localizedDescription)")
            }
        }
    }
}
