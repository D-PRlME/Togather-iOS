import Foundation
import Moya

class ChangeMyInfoViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = Account.ID ?? ""
    @Published var profileImageLink: String = Account.profileImagLink ?? ""
    @Published var introduce: String = ""
    @Published var positions: [String] = Account.positions ?? []
    @Published var showingAlert: Bool = false
    
    //"PM", "웹 프론트엔드", "백엔드", "안드로이드", "iOS", "디자인"
    //BACKEND, FRONTEND, IOS, DESIGNER, PM, ANDROID
    
    func GetMyInfo() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(MyProfileModel.self, from: result.data) {
                        self.introduce = data.introduce
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
        userClient.request(.changeMyInfo(name: name, picture: profileImageLink, introduce: introduce, position: positions)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    Account.ID = self.name
                    Account.positions = self.positions
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
