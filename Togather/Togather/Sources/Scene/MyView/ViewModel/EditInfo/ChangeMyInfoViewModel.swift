import Foundation
import SwiftUI
import Moya
import Alamofire

class EditInfoViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    let imageClient = MoyaProvider<ImageClient>(plugins: [MoyaLoggerPlugin()])
    @Published var name: String = Account.identifier ?? ""
    @Published var profileImageLink: String = Account.profileImageLink ?? ""
    @Published var introduce: String = ""
    @Published var positions: [String] = Account.positions ?? []
    @Published var showingAlert: Bool = false
    @Published var image: UIImage? = UIImage()
    func getMyInfo() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(ProfileModel.self, from: result.data) {
                        self.introduce = data.introduce
                        self.profileImageLink = data.profileImageUrl
                        print("성공적으로 프로필을 가져옴")
                    } else {
                        print("⚠️getMyInfo docoder error")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️getMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
    func changeMyInfo() {
        userClient.request(.changeMyInfo(name: name, picture: profileImageLink, introduce: introduce, position: positions)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    Account.identifier = self.name
                    Account.positions = self.positions
                    Account.profileImageLink = self.profileImageLink
                    self.showingAlert = true
                    print("성공적으로 프로필을 수정함")
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️changeMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
    func updateProfileImage() {
        print("작동: updateProfileImage")
        imageClient.request(.postImage([image!.jpegData(compressionQuality: 0.0) ?? Data()])) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 201:
                    if let data = try? JSONDecoder().decode(UploadImageModel.self, from: result.data) {
                        self.profileImageLink = data.imagesUrl.first ?? ""
                        Account.profileImageLink = data.imagesUrl.first ?? ""
                        print("profile url:", self.profileImageLink)
                        print("profile upload 성공")
                    } else {
                        print("⚠️image upload docoder error")
                    }
                default:
                    print(result.statusCode)
                }
            case .failure(let error):
                print("⛔️image upload Error: \(error.localizedDescription)")
            }
        }
    }
}
