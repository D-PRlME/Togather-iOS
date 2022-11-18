import Foundation
import Moya
import SwiftKeychainWrapper

class QuitAccountViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var inputPassword: String = ""
    @Published var wrongPW: Bool = false
    @Published var isSucced: Bool = false
    func deleteAccount() {
        userClient.request(.quitAccount(password: inputPassword)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("회원탈퇴(계정 삭제)")
                    Account.deleteAccount()
                    Token.removeToken()
                    KeychainWrapper.standard.removeObject(forKey: "auto")
                    KeychainWrapper.standard.removeObject(forKey: "id")
                    KeychainWrapper.standard.removeObject(forKey: "pw")
                    self.isSucced = true
                case 403:
                    print("올바르지 않은 비밀번호")
                    self.wrongPW = true
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️quitAccount Error: \(err.localizedDescription)")
            }
        }
    }
    func checkPassword() -> Bool {
        return pwCheck(inputPassword)
    }
    private func pwCheck(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
}
