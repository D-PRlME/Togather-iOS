import Foundation
import Moya

class ChangeMyInfoViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = Account.ID ?? ""
    @Published var profileImageLink: String = Account.profileImagLink ?? ""
    @Published var introduce: String = ""
    @Published var position: [String] = ["PM"]
    @Published var showingAlert: Bool = false
    
    func getMyInfo() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(MyProfileModel.self, from: result.data) {
                        self.introduce = data.introduce
//                        self.position = data.position
                        print("성공적으로 프로필을 가져옴")
                    } else {
                        print("⚠️getMyInfo docoder error")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️getMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
    
    func changeMyInfo() {
        userClient.request(.changeMyInfo(name: name, picture: profileImageLink, introduce: introduce, position: position)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    Account.ID = self.name
                    self.showingAlert = true
                    print("성공적으로 프로필을 수정함")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️changeMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
}
