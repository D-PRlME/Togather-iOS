import Foundation
import Moya

enum UserService {
    // 계정 관련
    case login(accountID: String, password: String)
    case signup(password: String, email: String, name: String)
    case logout
    case quitAccount(password: String)
    // 메일 관련
    case mailDuplicate(email: String)
    case mailSignup(email: String)
    case mailVerify(email: String, authCode: String)
    // 토큰 재발급
    case tokenReissue
    // 유저 정보 관련
    case changeMyInfo(name: String, picture: String, introduce: String, position: [String])
    case changePassword(oldPassword: String, newPassword: String)
    case getMyprofile
    case getUserProfile(userID: Int)
    // 비밀번호 변경
    case sendFindEmail(email: String)
    case changePasswordEmail(newPassword: String, email: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.55.240.35:8080/users")!
    }
    var path: String {
        switch self {

        case .login:
            return "/auth"
        case .signup:
            return ""
        case .mailDuplicate:
            return "/mail/duplicate"
        case .mailSignup:
            return "/mail/signup"
        case .mailVerify:
            return "/mail/verify"
        case .tokenReissue:
            return "/auth"
        case .changeMyInfo:
            return ""
        case .changePassword:
            return "/password"
        case .getMyprofile:
            return ""
        case .logout:
            return "/logout"
        case .quitAccount:
            return ""
        case .sendFindEmail:
            return "/mail"
        case .changePasswordEmail:
            return "/password"
        case .getUserProfile(userID: let userID):
            return "/\(userID)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup, .mailDuplicate, .mailSignup, .mailVerify, .sendFindEmail:
            return .post
        case .tokenReissue, .changePasswordEmail:
            return .put
        case .changeMyInfo, .changePassword:
            return .patch
        case .getMyprofile, .getUserProfile:
            return .get
        case .logout, .quitAccount:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case .tokenReissue, .getMyprofile, .logout, .getUserProfile:
            return .requestPlain
        case .mailDuplicate(let email):
            return .requestParameters(
                parameters:
                    [
                        "email": email
                    ],
                encoding: JSONEncoding.default)
        case .mailSignup(let email):
            return .requestParameters(
                parameters:
                    [
                        "email": email
                    ],
                encoding: JSONEncoding.default)
        case .mailVerify(let email, let authCode):
            return .requestParameters(
                parameters:
                    [
                        "email": email,
                        "auth_code": authCode
                    ],
                encoding: JSONEncoding.default)
        case .changeMyInfo(let name, let picture, let introduce, let position):
            return .requestParameters(
                parameters:
                    [
                        "name": name,
                        "profile_image_url": picture,
                        "introduce": introduce,
                        "positions": position
                    ],
                encoding: JSONEncoding.default)

        case .changePassword(let oldPassword, let newPassword):
            return .requestParameters(
                parameters:
                    [
                        "old_password": oldPassword,
                        "new_password": newPassword
                    ],
                encoding: JSONEncoding.default)
        case .login(let identify, let password):
            return .requestParameters(
                parameters:
                    [
                        "email": identify,
                        "password": password
                    ],
                encoding: JSONEncoding.default)
        case .signup(let password, let email, let name):
            return .requestParameters(
                parameters:
                    [
                        "password": password,
                        "name": name,
                        "email": email
                    ],
                encoding: JSONEncoding.default)
        case .sendFindEmail(let email):
            return .requestParameters(
                parameters:
                    [
                        "email": email
                    ],
                encoding: JSONEncoding.default)
        case .changePasswordEmail(let newPassword, let email):
            return .requestParameters(
                parameters:
                    [
                        "new_password": newPassword,
                        "email": email
                    ],
                encoding: JSONEncoding.default)
        case .quitAccount(let password):
            return .requestParameters(
                parameters:
                    [
                        "password": password
                    ],
                encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
            // 토큰 필요없음
        case .mailSignup, .mailVerify, .mailDuplicate, .signup, .login, .changePasswordEmail:
            return Header.tokenIsEmpty.header()
            // 리프레시 토큰
        case .tokenReissue:
            return Header.refreshToken.header()
            // 엑세스 토큰
        case .getMyprofile, .logout, .quitAccount, .changePassword, .changeMyInfo, .getUserProfile, .sendFindEmail:
            return Header.accessToken.header()
        }
    }
}
