import Foundation
import Moya

class SignUpEmailVerifyViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var isSuccess: Int?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var timer: Int = 300
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: self.timer >= 0) { _ in
            self.timer -= 1
        }
    }
    func sendEmailToUser() {
        userClient.request(.mailSignup(email: email)) { res in
            print("email: \(self.email)")
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅유저에게 이메일을 보냄")
                case 400:
                    print("이메일 형식또는 도메인(@dsm.hs.kr)이 잘못됨")
                case 409:
                    print("이메일이 중복됨")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️sendEmail error: \(err.localizedDescription)")
            }
        }
    }
    func emailVerify() {
        userClient.request(.mailVerify(email: email, authCode: code)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅인증 성공!")
                    self.isSuccess = 2
                case 401:
                    self.showError = true
                    self.errorMessage = "인증코드가 잘못됨"
                    print("인증코드가 잘못됨")
                default:
                    self.showError = true
                    self.errorMessage = "알수 없는 오류\n\(result.statusCode)"
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️emailVerity error: \(err.localizedDescription)")
            }
        }
    }
}
