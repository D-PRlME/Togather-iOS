import Foundation
import Moya
import SwiftKeychainWrapper
import Combine

class ChangePasswordVerifyViewModel: ObservableObject {
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
    // MARK: - 내 프로필 조회
    func getMyProfile() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    DispatchQueue.main.async {
                        if let data = try? JSONDecoder().decode(ChangePasswordModel.self, from: result.data) {
                            self.myEmail = data.email
                            self.sendChangePWEmail()
                        } else {
                            print("⚠️myProfile PW docoder error")
                        }
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️myProfile PW Error: \(err.localizedDescription)")
            }
        }
    }
    // MARK: - 비밀번호 변경 이메일 전송

    func sendChangePWEmail() {
        userClient.request(.sendFindEmail(email: myEmail)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    self.isError = false
                    print("✅비밀번호 변경 이메일 전송")
                case 400:
                    self.isError = true
                    self.errorMessage = "이메일 형식또는 도메인(@dsm.hs.kr)이 잘못되었습니다."
                case 409:
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
    // MARK: - 이메일 인증

    func emailVerify() {//
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
