import Foundation
import Moya
import SwiftKeychainWrapper

class SignUpSuccessViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var code: String = ""
    @Published var isSuccess: Int?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    func checkTotalSignUpValue(_ email: String, _ password: String, _ name: String) -> Bool {
        if pwCheck(password) && nameCheck(name) && emailCheck(email) {
            return true
        } else {
            return false
        }
    }
    func emailValueCheck(_ email: String) -> Bool {
        if email.isEmpty == false {
            return emailCheck(email)
        } else {
            return true
        }
    }
    func passwordValueCheck(_ password: String) -> Bool {
        if password.isEmpty == false {
            return pwCheck(password)
        } else {
            return true
        }
    }
    private func nameCheck(_ name: String) -> Bool {
        if name.isEmpty == false {
            return true
        } else {
            return false
        }
    }
    private func emailCheck(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@dsm+\\.hs+\\.kr"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    private func pwCheck(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
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
                            KeychainWrapper.standard.set(true, forKey: "auto")
                            KeychainWrapper.standard.set(self.email, forKey: "id")
                            KeychainWrapper.standard.set(self.password, forKey: "pw")
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
