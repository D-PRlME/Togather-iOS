import SwiftUI
import SwiftUIFlowLayout
import Kingfisher
import Moya
import SwiftUIPullToRefresh

struct HomeView: View {
    @State private var isClose: Bool = false
    @Binding var tabBarIndex: TabIndex
    @Binding var bindingTag: String
    @StateObject var homeViewModel = HomeViewModel()
    let animation = Animation
        .linear
        .repeatForever(autoreverses: false)
    var body: some View {
        ZStack {
            ColorManager.BackgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                RefreshableScrollView { done in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        homeViewModel.post()
                        homeViewModel.getTagList()
                        done()
                    }
                } content: {
                    VStack(spacing: 0) {
                        TagSelectList(
                            tags: $homeViewModel.tagList,
                            bindingTag: $bindingTag,
                            action: {
                                tabBarIndex = .search
                            }
                        )
                        ForEach(homeViewModel.postList, id: \.postID) { data in
                            PostForm(
                                close: $isClose,
                                tabIndex: $tabBarIndex,
                                postData: data
                            )
                            .padding(.horizontal, 14)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.top, 12)
                .padding(.bottom, getSafeAreaBot() ? 86 : 106)
                .onAppear {
                    DispatchQueue.global().async {
                        homeViewModel.getTagList()
                        homeViewModel.post()
                    }
                }
                .onChange(of: isClose) { newValue in
                    if newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            homeViewModel.post()
                            self.isClose = false
                        }
                    }
                }
            }
        }
    }
}

// struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
// }
