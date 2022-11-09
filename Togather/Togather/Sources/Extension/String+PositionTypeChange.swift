import Foundation

extension String {
    //"PM", "웹 프론트엔드", "백엔드", "안드로이드", "iOS", "디자인"
    //BACKEND, FRONTEND, IOS, DESIGNER, PM, ANDROID
    var positionTypeChange: String {
        switch self {
        //KR -> EN
        case "PM": return "PM"
        case "웹 프론트엔드": return "FRONTEND"
        case "백엔드": return "BACKEND"
        case "안드로이드": return "ANDROID"
        case "iOS": return "IOS"
        case "디자인": return "DESIGNER"
            
        //EN -> KR
        case "BACKEND": return "백엔드"
        case "FRONTEND": return "웹 프론트엔드"
        case "IOS": return "iOS"
        case "DESIGNER": return "디자인"
        case "ANDROID": return "안드로이드"
            
        default: return ""
        }
    }
}
