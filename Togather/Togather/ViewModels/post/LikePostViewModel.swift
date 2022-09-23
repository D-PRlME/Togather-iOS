import Foundation
import Moya
import SwiftUI

class LikePostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    @Published var postID: CLong = 0
    
    
}


