import SwiftUI

struct TabBarItem: View {
    @Binding var tabIndex: TabIndex
    let thisValue: TabIndex
    let proxy: GeometryProxy
    private func changeTabIndexToName() -> String {
        switch thisValue {
        case .home:
            return "홈"
        case .chat:
            return "채팅"
        case .write:
            return "글쓰기"
        case .mypage:
            return "나"
        case .search:
            return "검색"
        }
    }
    private func changeTabIndexToImage() -> Image {
        switch thisValue {
        case .home:
            return Image(tabIndex == .home ? "HomeOn" : "HomeOff")
        case .chat:
            return Image(tabIndex == .chat ? "ChatOn" : "ChatOff")
        case .write:
            return Image(tabIndex == .write ? "WritingOn" : "WritingOff")
        case .mypage:
            return Image(tabIndex == .mypage ? "MyOn" : "MyOff")
        case .search:
            return Image(tabIndex == .search ? "SearchOn" : "SearchOff")
        }
    }
    private func changeTabIndexToColor() -> Color {
        switch thisValue {
        case .home:
            return tabIndex == .home ? .main : .whiteElevated4
        case .chat:
            return tabIndex == .chat ? .main : .whiteElevated4
        case .write:
            return tabIndex == .write ? .main : .whiteElevated4
        case .mypage:
            return tabIndex == .mypage ? .main : .whiteElevated4
        case .search:
            return tabIndex == .search ? .main : .whiteElevated4
        }
    }
    var body: some View {
        Button {
            tabIndex = thisValue
        } label: {
            VStack {
                changeTabIndexToImage()
                    .font(.system(size: 25))
                    .foregroundColor(changeTabIndexToColor())
                    .frame(width: 28, height: 28)
                Text(changeTabIndexToName())
                    .font(.custom("Pretendard-Bold", size: 14))
                    .foregroundColor(changeTabIndexToColor())
                Spacer()
            }
            .frame(width: proxy.size.width/6, height: 50)
        }
        .buttonStyle(.plain)
    }
}

//struct TabBarItem_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarItem(tabIndex: .constant(.home), proxy: <#GeometryProxy#>)
//    }
//}
