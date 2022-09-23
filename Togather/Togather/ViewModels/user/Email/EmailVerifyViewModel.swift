import Foundation
import Moya

class EmailVerifyViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    @Published var code: String = ""
    
    @Published var accessVerify: Int?
    
    
    func EmailVerify() {
        userClient.request(.mailVerify(email: email, authCode: code)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    self.accessVerify = 1
                    print("✅인증 성공!")
                case 401:
                    print("인증코드가 잘못됨")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️emailVerity error: \(err.localizedDescription)")
            }
        }
    }
}
