
import SwiftUI

enum TabIndex {
    case home, write, mypage, search
}

struct TabBarView: View {
    @State var tabIndex = TabIndex.home
    @State var largerScale: CGFloat = 1.6
    
    func changeMyView(tableIndex: TabIndex) -> ShowView {
        switch tabIndex {
        case .home:
            return ShowView(Number: 1)
        case .write:
            return ShowView(Number: 2)
        case .search:
            return ShowView(Number: 3)
        case .mypage:
            return ShowView(Number: 4)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    changeMyView(tableIndex: tabIndex)
                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(Color("TabBarStroke"))
                                .frame(width: proxy.size.width, height: 2)
                            Rectangle()
                                .foregroundColor(Color("TabBarFill"))
                                .frame(width: proxy.size.width, height: UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                        }
                        HStack(alignment: .top, spacing: 0) {
                            Button {
                                print("----------------------------------")
                                print("Home View")
                                print("----------------------------------")
                                withAnimation {
                                    tabIndex = .home
                                }
                            } label: {
                                VStack {
                                    Image(systemName: "house.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(tabIndex == .home ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                    
                                    Text("홈")
                                        .font(.custom("Pretendard-Bold", size: 14))
                                        .foregroundColor(tabIndex == .home ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                    Spacer()
                                }
                                .frame(width: proxy.size.width/4, height: 50)
                                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 5 : 25)
                            }
                            Button {
                                print("----------------------------------")
                                print("Writing View")
                                print("----------------------------------")
                                withAnimation {
                                    tabIndex = .write
                                }
                            } label: {
                                VStack {
                                    Image(systemName: "plus.circle")
                                        .font(.system(size: 25))
                                        .foregroundColor(tabIndex == .write ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                        .frame(width: 28, height: 28)
                                    Text("글쓰기")
                                        .font(.custom("Pretendard-Bold", size: 14))
                                        .foregroundColor(tabIndex == .write ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                    Spacer()
                                }
                                .frame(width: proxy.size.width/4, height: 50)
                            }
                            
                            Button {
                                print("----------------------------------")
                                print("Search View")
                                print("----------------------------------")
                                withAnimation {
                                    tabIndex = .search
                                }
                            } label: {
                                VStack {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 25))
                                        .foregroundColor(tabIndex == .search ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                        .frame(width: 28, height: 28)
                                    Text("검색")
                                        .font(.custom("Pretendard-Bold", size: 14))
                                        .foregroundColor(tabIndex == .mypage ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                    Spacer()
                                }
                                .frame(width: proxy.size.width/4, height: 50)
                            }
                            Button {
                                print("----------------------------------")
                                print("My View")
                                print("----------------------------------")
                                withAnimation {
                                    tabIndex = .mypage
                                }
                            } label: {
                                VStack {
                                    Image(systemName: "person")
                                        .font(.system(size: 25))
                                        .foregroundColor(tabIndex == .mypage ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                        .frame(width: 28, height: 28)
                                    Text("나")
                                        .font(.custom("Pretendard-Bold", size: 14))
                                        .foregroundColor(tabIndex == .mypage ? Color("TabBarSelectedColor") : Color("TabBarNoSelectedColor"))
                                    Spacer()
                                }
                                .frame(width: proxy.size.width/4, height: 50)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//부분 Corner Radiusd
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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
