import Foundation
import Moya

class ChangeMyInfoViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
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
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
                    } else {
                        print("⚠️changeMyInfo Error decode")
                    }
                }
                
            case .failure(let err):
                print("⛔️changeMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
}
