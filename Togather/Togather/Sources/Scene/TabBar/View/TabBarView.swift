
import SwiftUI

enum TabIndex {
    case home, chat, write, mypage, search
}

struct TabBarView: View {
    @State var tabIndex = TabIndex.home
    @State var showModal = false
    let paddingValue: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 40
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    ShowView(tabIndex: tabIndex)
                        .padding(.top, paddingValue)
                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(Color("TabBarStroke"))
                                .frame(width: proxy.size.width, height: 1)
                            Rectangle()
                                .foregroundColor(Color("TabBarFill"))
                                .frame(width: proxy.size.width, height: UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                        }
                        HStack(alignment: .top, spacing: 0) {
                            TabBarItem(tabIndex: $tabIndex,
                                       thisValue: .home,
                                       proxy: proxy)
                            TabBarItem(tabIndex: $tabIndex,
                                       thisValue: .chat,
                                       proxy: proxy)
                            SearchModalButton(tabIndex: $tabIndex,
                                              showModal: $showModal,
                                              proxy: proxy)
                            TabBarItem(tabIndex: $tabIndex,
                                       thisValue: .search,
                                       proxy: proxy)
                            TabBarItem(tabIndex: $tabIndex,
                                       thisValue: .mypage,
                                       proxy: proxy)
                        }
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 5 : 25)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
