import Foundation
import Moya

class EmailDuplicateViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var viewTag: Int? = nil
    
    
    func emailDuplicate() {
        userClient.request(.mailDuplicate(email: email)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204, 200:
                    print("이메일 중복 확인 성공")
                    self.viewTag = 1
                case 400:
                    self.showingAlert = true
                    self.alertMessage = "dsm.hs.kr이 들어간 이메일을 사용해주세요."
                    print("이메일 형식또는 도메인(@dsm.hs.kr)이 잘못됨")
                case 409:
                    self.showingAlert = true
                    self.alertMessage = "이미 등록된 이메일 입니다."
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
                        print("⚠️emailDupilcate Error handling")
                    }
                }
            case .failure(let err):
                print("⛔️emailDupilcate error: \(err.localizedDescription)")
            }
        }
    }
    
}
