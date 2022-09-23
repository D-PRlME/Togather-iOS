import Foundation
import Moya

class ChangePasswordViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = ""
    @Published var profileImageLink: String = ""
    @Published var showingAlert: Bool = false
    
    func signUpClient() {
        userClient.request(.changeMyInfo(name: name, picture: profileImageLink)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    self.showingAlert = true
                case 400:
                    print("Bad request")
                case 404:
                    print("알 수 없는 비밀번호")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️changePassword Error: \(err.localizedDescription)")
            }
        }
    }
}
