import Foundation

extension Date {
    func timeFormater() -> String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let time = date.string(from: now)
        return time
    }
}
