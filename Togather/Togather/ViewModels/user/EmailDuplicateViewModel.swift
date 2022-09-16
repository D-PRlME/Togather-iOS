import Foundation
import Moya

class EmailDuplicateViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>()
    
    @Published var email: String = ""
    @Published var showingAlert: Bool = false
    
    
    func emailDuplicate() {
        userClient.request(.mailDuplicate(email: email)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    print("이메일 중복 확인 성공")
                default:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(ErrorModel.self, from: result.data) {
                        print("status: \(data.status)")
                        print("code: \(data.code)")
                        print("message: \(data.message)")
                    } else {
                        print("⚠️emailDupilcate Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️emailDupilcate error: \(err.localizedDescription)")
            }
        }
    }
    
}
