import Foundation
import SwiftUI
import Moya
import Alamofire

class ChangeMyInfoViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = Account.ID ?? ""
    @Published var profileImageLink: String = Account.profileImagLink ?? ""
    @Published var introduce: String = ""
    @Published var positions: [String] = Account.positions ?? []
    @Published var showingAlert: Bool = false
    
    //"PM", "웹 프론트엔드", "백엔드", "안드로이드", "iOS", "디자인"
    //BACKEND, FRONTEND, IOS, DESIGNER, PM, ANDROID
    
    func getMyInfo() {
        userClient.request(.getMyprofile) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    if let data = try? JSONDecoder().decode(MyProfileModel.self, from: result.data) {
                        self.introduce = data.introduce
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
                    Account.ID = self.name
                    Account.positions = self.positions
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
    /*
    func updateProfileImage(_ image : UIImage){
        
        let imageData = image.jpegData(compressionQuality: 1)!
        let url = ""
        
        upload(image: imageData, to: url)
        
    }//end of function
    func upload(image: Data, to url: String) {
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: "newsletter_image", fileName: "\(self.tfTitle.text ?? "")_logo.png", mimeType: "image/jpeg")
        }, to: url
                  , headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            switch data.result{
            case .success(_):
                    print("=== upload 성공 ===")
            case .failure(let error):
                print(error.errorDescription ?? "error")
            }
        })
    }
     */
}
