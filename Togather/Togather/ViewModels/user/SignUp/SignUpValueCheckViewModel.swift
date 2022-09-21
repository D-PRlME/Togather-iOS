import Foundation

class SignUpValueCheckViewModel: ObservableObject {
    
    func CheckTotalSignUpValue(_ email: String, _ password: String, _ name: String) -> Bool {
        if PwCheck(password) && NameCheck(name) && EmailCheck(email) {
            return true
        } else {
            return false
        }
    }
    
    func EmailValueCheck(_ email: String) -> Bool {
        if email.isEmpty == false {
            return EmailCheck(email)
        } else {
            return true
        }
    }
    
    func PasswordValueCheck(_ password: String) -> Bool {
        if password.isEmpty == false {
            return PwCheck(password)
        } else {
            return true
        }
    }
    
    private func NameCheck(_ name: String) -> Bool {
        if name.isEmpty == false {
            return true
        } else {
            return false
        }
    }
    
    private func EmailCheck(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@dsm+\\.hs+\\.kr"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func PwCheck(_ pw: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: pw)
    }
}
