
import SwiftUI
struct TabBarView: View {
    @State var selection: Int = 0
    @State var showModal = false
    init() {
        UITabBar.appearance().scrollEdgeAppearance = .init()
    }
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(selection == 0 ? "HomeOn" : "HomeOff")
                        .font(.system(size: 25))
                    Text("홈")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
                .tag(0)
            ChatListView()
                .tabItem {
                    Image(selection == 1 ? "ChatOn" : "ChatOff")
                        .font(.system(size: 25))
                    Text("채팅")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
                .tag(1)
            WritingView(showModal: $showModal)
                .tabItem {
                    Image(selection == 2 ? "WritingOn" : "WritingOff")
                        .font(.system(size: 25))
                    Text("글쓰기")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
                .tag(2)
            SearchView()
                .tabItem {
                    Image(selection == 3 ? "SearchOn" : "SearchOff")
                        .font(.system(size: 25))
                    Text("검색")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
                .tag(3)
            MyView()
                .tabItem {
                    Image(selection == 4 ? "MyOn" : "MyOff")
                        .font(.system(size: 25))
                    Text("채팅")
                        .font(.custom("Pretendard-Bold", size: 14))
                }
                .tag(4)
        }
        .navigationBarHidden(true)
        .accentColor(Color("TabBarSelectedColor"))
        .tabViewStyle(.automatic)
    }
}

//부분 Corner Radiusd
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 90
        return sizeThatFits
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
