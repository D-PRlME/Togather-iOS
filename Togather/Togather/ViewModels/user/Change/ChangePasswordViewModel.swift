import Foundation
import Moya

class ChangePasswordViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>()
    
    @Published var name: String = ""
    @Published var profileImageLink: String = ""
    @Published var showingAlert: Bool = false
    
    func signUpClient() {
        UserClient.request(.changeMyInfo(name: name, picture: profileImageLink)) { res in
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
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
                    } else {
                        print("⚠️changePassword Error decode")
                    }
                }
                
            case .failure(let err):
                print("⛔️changePassword Error: \(err.localizedDescription)")
            }
        }
    }
}
