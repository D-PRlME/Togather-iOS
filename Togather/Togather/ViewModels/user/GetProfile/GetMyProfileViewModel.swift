import Foundation
import Moya

class GetMyProfileViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var myID: String = ""
    @Published var myEmail: String = ""
    @Published var myProfilImageLink: String = ""
    
    func signUpClient() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(MyProfileModel.self, from: result.data) {
                        self.myID = data.name
                        self.myEmail = data.email
                        self.myProfilImageLink = data.profile_image_url
                    } else {
                        print("⚠️getMyProfile docoder error")
                    }
                default:
                    print(result.statusCode)
                }
                
            case .failure(let err):
                print("⛔️getMyProfile Error: \(err.localizedDescription)")
            }
        }
    }
}
