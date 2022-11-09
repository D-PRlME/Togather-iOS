import Foundation
import Moya

class TokenAuthViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    func tokenReissueClient() {
        userClient.request(.tokenReissue) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                            Token.accessToken = data.accessToken
                            Token.refreshToken = data.refreshToken
                            print("token 재발급")
                            print("🔊\(data.expiredAt)")
                        } else {
                            print("⚠️tokenAuth docoder error")
                        }
                    }
                case 404:
                    print("알수없는 토큰")
                default:
                    print("\(result.statusCode)")
                }
                
            case .failure(let err):
                print("⛔️tokenAuth Error: \(err.localizedDescription)")
            }
        }
    }
}
