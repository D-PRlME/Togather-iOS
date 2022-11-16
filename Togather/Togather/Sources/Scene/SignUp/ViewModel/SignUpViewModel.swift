import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var code: String = ""
    @Published var isSuccess: Int?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    func emailDuplicate() {
        userClient.request(.mailDuplicate(email: email)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204, 200:
                    print("이메일 중복 확인 성공")
                    self.isSuccess = 1
                case 400:
                    self.showError = true
                    self.errorMessage = "dsm.hs.kr이 들어간 이메일을 사용해주세요."
                    print("이메일 형식또는 도메인(@dsm.hs.kr)이 잘못됨")
                case 409:
                    self.showError = true
                    self.errorMessage = "이미 등록된 이메일 입니다."
                    print("이메일이 중복됨")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️emailDupilcate error: \(err.localizedDescription)")
            }
        }
    }
    func sendEmailToUser() {
        userClient.request(.mailSignup(email: email)) { res in
            print("email: \(self.email)")
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅유저에게 이메일을 보냄")
                case 400:
                    print("이메일 형식또는 도메인(@dsm.hs.kr)이 잘못됨")
                case 409:
                    print("이메일이 중복됨")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️sendEmail error: \(err.localizedDescription)")
            }
        }
    }
    func emailVerify() {
        userClient.request(.mailVerify(email: email, authCode: code)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    print("✅인증 성공!")
                    self.isSuccess = 2
                case 401:
                    self.showError = true
                    self.errorMessage = "인증코드가 잘못됨"
                    print("인증코드가 잘못됨")
                default:
                    self.showError = true
                    self.errorMessage = "알수 없는 오류\n\(result.statusCode)"
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️emailVerity error: \(err.localizedDescription)")
            }
        }
    }
    func signUpClient() {
        userClient.request(.signup(password: password, email: email, name: name)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...201:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(TokenModel.self, from: result.data) {
                            Token.accessToken = data.accessToken
                            Token.refreshToken = data.refreshToken
                            self.isSuccess = 3
                            self.getMyProFile()
                            print("🔊\(data.expiredAt)")
                        } else {
                            print("⚠️signup docoder error")
                        }
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️signup Error: \(err.localizedDescription)")
            }
        }
    }
    private func getMyProFile() {
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
