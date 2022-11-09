import Foundation
import Moya

class LoginViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var viewTag: Int?
    @Published var showProgrees: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func login() {
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
                            print("✅로그인 성공")
                            print("🔊\(data.expiredAt)")
                            self.viewTag = 1
                        } else {
                            print("⚠️login docoder error")
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showProgrees = false
                    }
                case 400:
                    DispatchQueue.main.async {
                        self.errorMessage = "올바르지 않은 아이디/비밀번호 형식입니다."
                        self.showError = true
                        self.showProgrees = false
                    }
                case 403:
                    DispatchQueue.main.async {
                        self.errorMessage = "올바르지 않은 비밀번호 입니다."
                        self.showError = true
                        self.showProgrees = false
                    }
                case 404:
                    DispatchQueue.main.async {
                        self.errorMessage = "찾을 수 없는 아이디 입니다."
                        self.showError = true
                        self.showProgrees = false
                    }
                default:
                    DispatchQueue.main.async {
                        self.errorMessage = "알 수 없는 오류입니다. 문의 바랍니다!\n(code: \(result.statusCode))"
                        self.showError = true
                        self.showProgrees = false
                    }
                }
            case .failure(let err):
                print("⛔️login error: \(err.localizedDescription)")
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
