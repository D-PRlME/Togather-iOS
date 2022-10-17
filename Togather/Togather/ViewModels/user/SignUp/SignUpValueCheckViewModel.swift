import Foundation

class SignUpValueCheckViewModel: ObservableObject {
    
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
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func pwCheck(_ pw: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: pw)
    }
}
