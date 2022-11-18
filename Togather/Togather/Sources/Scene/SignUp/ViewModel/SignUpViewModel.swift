import Foundation
import Moya

class SignUpViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    @Published var email: String = ""
    @Published var isSuccess: Int?
    @Published var code: String = ""
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
}
