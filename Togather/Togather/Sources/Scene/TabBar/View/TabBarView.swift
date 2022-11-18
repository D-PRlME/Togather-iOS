import SwiftUI

enum TabIndex {
    case home, chat, write, mypage, search
}

func getSafeAreaBot() -> Bool {
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    return (keyWindow?.safeAreaInsets.bottom) == 0
}

struct TabBarView: View {
    @State private var tabIndex = TabIndex.home
    @State private var showModal = false
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    ShowView(tabIndex: tabIndex)
                        .padding(.top, getSafeAreaBot() ? 0 : 40)
                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(Color("TabBarStroke"))
                                .frame(width: proxy.size.width, height: 1)
                            Rectangle()
                                .foregroundColor(Color("TabBarFill"))
                                .frame(width: proxy.size.width, height: getSafeAreaBot() ? 86 : 106)
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
                        .padding(.bottom, getSafeAreaBot() ? 5 : 25)
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
