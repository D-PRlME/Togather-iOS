import Foundation
import Moya
import SwiftUI

class DeletePostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    @Published var postID: Int = 0
    
    
}


