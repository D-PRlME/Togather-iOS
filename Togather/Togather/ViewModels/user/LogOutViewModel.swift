import Foundation
import Moya

class LogOutViewModel: ObservableObject {
    let UserClient = MoyaProvider<UserService>()
    
    func signUpClient() {
        UserClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("로그아웃 함")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("============🆘============")
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                        print("==========================")
                    } else {
                        print("⚠️Logout Error decode")
                    }
                }
                
            case .failure(let err):
                print("⛔️Logout Error: \(err.localizedDescription)")
            }
        }
    }
}
