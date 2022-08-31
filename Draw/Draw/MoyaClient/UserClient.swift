import Foundation
import Moya

enum UserService {
    case login(accountID: String, password: String)
    case signup(accountID: String, password: String, email: String, name: String, authCode: String)
    case mailDuplicate(email: String)
    case mailSignup(email: String)
    case mailVerify(email: String, authCode: String)
    case tokenReissue
    case changeMyInfo(name: String, picture: String)
    case changePassword(oldPassword: String, newPassword: String)
    case getMyprofile
    case logout
    case quitAccount
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "url/users")!
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
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .login, .signup, .mailDuplicate, .mailSignup, .mailVerify:
            return .post
        case .tokenReissue:
            return .put
        case .changeMyInfo, .changePassword:
            return .patch
        case .getMyprofile:
            return .get
        case .logout, .quitAccount:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
            
        case .tokenReissue, .getMyprofile, .logout, .quitAccount:
            return .requestPlain
        case .mailDuplicate(let email):
            return .requestJSONEncodable(["email" : email])
        case .mailSignup(let email):
            return .requestJSONEncodable(["email" : email])
        case .mailVerify(let email, let authCode):
            return .requestJSONEncodable(["email" : email, "auth_code" : authCode])
        case .changeMyInfo(let name, let picture):
            return .requestJSONEncodable(["name" : name, "picture" : picture])
        case .changePassword(let oldPassword, let newPassword):
            return .requestJSONEncodable(["old_password" : oldPassword, "new_password" : newPassword])
        case .login(let ID, let PW):
            return .requestJSONEncodable(["account_id" : ID, "password" : PW])
        case .signup(let accountID, let password, let email, let name,_):
            return .requestJSONEncodable(["account_id" : accountID, "password" : password, "name" : name, "email" : email])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mailSignup, .mailVerify, .mailDuplicate, .signup, .login, .changeMyInfo, .changePassword:
            return Header.tokenIsEmpty.header()
        case  .tokenReissue:
            return Header.refreshToken.header()
        case .getMyprofile, .logout, .quitAccount:
            return Header.accessToken.header()
        }
    }
}
