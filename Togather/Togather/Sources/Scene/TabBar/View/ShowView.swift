import SwiftUI
struct ShowView: View {
    @Binding var tabIndex: TabIndex
    @State private var bindingTag = ""
    var body: some View {
        VStack {
            switch tabIndex {
            case .home:
                HomeView(tabBarIndex: $tabIndex, bindingTag: $bindingTag)
            case .chat:
                ChatListView()
            case .write:
                EmptyView()
            case .search:
                SearchView(tagBtnValue: $bindingTag, tabIndex: $tabIndex)
            case .mypage:
                MyView()
            }
        }
    }
}
//
// struct ShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowView(tabIndex: )
//    }
// }
