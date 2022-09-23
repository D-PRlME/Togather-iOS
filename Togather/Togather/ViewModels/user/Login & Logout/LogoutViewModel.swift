import Foundation
import Moya

class LogoutViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    func signUpClient() {
        userClient.request(.logout) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("로그아웃 함")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️Logout Error: \(err.localizedDescription)")
            }
        }
    }
}
