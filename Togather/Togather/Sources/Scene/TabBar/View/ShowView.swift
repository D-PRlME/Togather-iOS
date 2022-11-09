
import SwiftUI

struct ShowView: View {
    
    let tabIndex: TabIndex
    
    var body: some View {
        VStack {
            switch tabIndex {
            case .home:
                HomeView()
            case .chat:
                ChatListView()
            case .write:
                SearchView()
            case .search:
                SearchView()
            case .mypage:
                MyView()
            }
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView(tabIndex: .home)
    }
}
