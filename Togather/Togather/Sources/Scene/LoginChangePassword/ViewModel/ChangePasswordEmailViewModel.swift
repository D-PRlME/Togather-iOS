import Foundation
import Moya
import SwiftKeychainWrapper
import Combine

class ChangePasswordEmailViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var myEmail: String = ""
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var goEnterPW: Int?
    // MARK: - 비밀번호 변경 이메일 전송

    func sendChangePWEmail() {
        userClient.request(.sendFindEmail(email: myEmail)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅비밀번호 변경 이메일 전송")
                    self.goEnterPW = 1
                case 400:
                    self.isError = true
                    self.errorMessage = "이메일 형식또는 도메인(@dsm.hs.kr)이 잘못되었습니다."
                case 404:
                    self.isError = true
                    self.errorMessage = "찾을 수 없는 이메일 입니다."
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️sendFindEmail Error: \(err.localizedDescription)")
            }
        }
    }
}
