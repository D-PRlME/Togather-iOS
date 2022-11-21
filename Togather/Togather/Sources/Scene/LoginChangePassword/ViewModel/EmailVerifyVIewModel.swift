import Foundation
import Moya
import SwiftKeychainWrapper
import Combine

class EmailVerifyVIewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var authCode: String = ""
    @Published var myEmail: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var goEnterPW: Int?
    @Published var timer: Int = 300
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: self.timer >= 0) { _ in
            self.timer -= 1
        }
    }
    // MARK: - 이메일 인증

    func emailVerify() {
        userClient.request(.mailVerify(email: myEmail, authCode: authCode)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    self.isError = false
                    self.goEnterPW = 1
                    print("✅인증 성공")
                case 400:
                    self.isError = true
                    self.errorMessage = "올바르지 않은 인증코드 입니다."
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️emailVerify Error: \(err.localizedDescription)")
            }
        }
    }
}
