import Foundation
import Moya
import SwiftKeychainWrapper

class ContentViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullScreenToLoginView: Bool = false
    @Published var fullScreenToTabBarView: Bool = false
    func justLogin() {
        fullScreenToLoginView.toggle()
    }
    func autoLogin() {
        userClient.request(.login(accountID: email, password: password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                            Token.accessToken = data.accessToken
                            Token.refreshToken = data.refreshToken
                            self.getMyProFile()
                            print("✅자동로그인 성공")
                            print("🔊\(data.expiredAt)")
                            self.fullScreenToTabBarView.toggle()
                        } else {
                            print("⚠️login docoder error")
                            self.justLogin()
                        }
                    }
                default:
                    print("자동로그인 실패")
                    self.justLogin()
                }
            case .failure(let err):
                print("⛔️autologin error: \(err.localizedDescription)")
                self.justLogin()
            }
        }
    }
    func getMyProFile() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(ProfileModel.self, from: result.data) {
                        Account.setAccount(
                            id: data.name,
                            email: data.email,
                            profileImagLink: data.profileImageUrl,
                            positions: data.positions
                        )
                    } else {
                        print("⚠️myProfile LG docoder error")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️myProfile LG Error: \(err.localizedDescription)")
            }
        }
    }
}
