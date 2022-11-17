import Foundation
import SwiftKeychainWrapper

struct Account {
    static var localEmail: String?
    static var email: String? {
        get {
            localEmail = KeychainWrapper.standard.string(forKey: "Account.User.Email")
            return localEmail
        }
        set(newEmail) {
            KeychainWrapper.standard.set(newEmail ?? "nil", forKey: "Account.User.Email")
            localEmail = newEmail
        }
    }
    static var localID: String?
    static var identifier: String? {
        get {
            localID = KeychainWrapper.standard.string(forKey: "Account.User.ID")
            return localID
        }
        set(newID) {
            KeychainWrapper.standard.set(newID ?? "nil", forKey: "Account.User.ID")
            localID = newID
        }
    }
    static var localProfileImageLink: String?
    static var profileImageLink: String? {
        get {
            localProfileImageLink = KeychainWrapper.standard.string(forKey: "Account.User.ProfileImagLink")
            return localProfileImageLink
        }
        set(newProfileImagLink) {
            KeychainWrapper.standard.set(newProfileImagLink ?? "nil", forKey: "Account.User.ProfileImagLink")
            localProfileImageLink = newProfileImagLink
        }
    }
    static var localPositions: [String]?
    static var positions: [String]? {
        get {
            localPositions = UserDefaults.standard.stringArray(forKey: "Account.User.Positions")
            return localPositions
        }
        set(newPositions) {
            UserDefaults.standard.set(newPositions, forKey: "Account.User.Positions")
            localPositions = newPositions
        }
    }
    static func deleteAccount() {
        self.identifier = nil
        self.email = nil
        self.profileImageLink = nil
        self.positions = nil
    }
    static func setAccount(id: String?, email: String?, profileImagLink: String?, positions: [String]?) {
        self.identifier = id
        self.email = email
        self.profileImageLink = profileImagLink
        self.positions = positions
    }
}
