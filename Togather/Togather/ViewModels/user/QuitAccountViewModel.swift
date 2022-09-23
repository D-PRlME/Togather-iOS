import Foundation
import Moya

class QuitAccountViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    func signUpClient() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("회원탈퇴(계정 삭제)")
                default:
                    print(result.statusCode)
                }
                
            case .failure(let err):
                print("⛔️quitAccount Error: \(err.localizedDescription)")
            }
        }
    }
}
