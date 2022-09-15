import Foundation
import Moya

class SendEmailViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>()
    
    @Published var email: String = ""
    @Published var access: Bool = false
    
    
    func SendEmailToUser() {
        userClient.request(.mailSignup(email: email)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    print("✅유저에게 이메일을 보냄")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️sendEmail Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️sendEmail error: \(err.localizedDescription)")
            }
        }
        
    }
}
