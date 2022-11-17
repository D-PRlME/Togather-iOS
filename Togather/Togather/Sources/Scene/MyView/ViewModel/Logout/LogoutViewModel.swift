import Foundation
import Moya
import SwiftKeychainWrapper

class LogoutViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var isSucced: Bool = false
    func logout() {
        userClient.request(.logout) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    Account.deleteAccount()
                    Token.removeToken()
                    KeychainWrapper.standard.removeObject(forKey: "auto")
                    KeychainWrapper.standard.removeObject(forKey: "id")
                    KeychainWrapper.standard.removeObject(forKey: "pw")
                    self.isSucced = true
                    print("로그아웃")
                default:
                    print("\(result.statusCode)")
                }
            case .failure(let err):
                print("⛔️logout error: \(err.localizedDescription)")
            }
        }
    }
}
