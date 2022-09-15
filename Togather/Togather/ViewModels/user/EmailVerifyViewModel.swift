import Foundation
import Moya

class EmailVerifyViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>()
    
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var accessVerify: Bool = false
    
    
    func EmailVerify() {
        userClient.request(.mailVerify(email: email, authCode: code)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    self.accessVerify = true
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️emailVerify Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️emailVerity error: \(err.localizedDescription)")
            }
        }
    }
}
