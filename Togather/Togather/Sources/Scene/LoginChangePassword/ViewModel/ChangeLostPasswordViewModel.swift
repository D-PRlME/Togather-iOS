import Foundation
import Moya
import SwiftKeychainWrapper
import Combine

class ChangeLostPasswordViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var newPassword: String = ""
    @Published var email: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var goSucced: Int?
    // MARK: - 비밀번호 변경

    func changePassword() {
        userClient.request(.changePasswordEmail(newPassword: newPassword, email: email)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅비번 변경 성공")
                    self.goSucced = 1
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️changePasswordEmail Error: \(err.localizedDescription)")
            }
        }
    }
    func passwordValueCheck() -> Bool {
        return pwCheck(newPassword)
    }
    private func pwCheck(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
}
