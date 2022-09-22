import Foundation
import Moya

class SendEmailViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    
    func SendEmailToUser() {
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
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
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
