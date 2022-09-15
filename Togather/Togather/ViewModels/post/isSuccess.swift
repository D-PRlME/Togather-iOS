import Foundation


class isSuccess: ObservableObject {
    @Published var showModal = true
    
    func changeStatus(_ bool: Bool) {
        showModal = bool
    }
}

