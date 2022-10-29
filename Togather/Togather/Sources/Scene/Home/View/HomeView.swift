
import SwiftUI
import SwiftUIFlowLayout
import Kingfisher
import Moya
import SwiftUIPullToRefresh

struct HomeView: View {
    
    @State var isClose: Bool = false

    @StateObject var homeViewModel = HomeViewModel()
    let animation = Animation
        .linear
        .repeatForever(autoreverses: false)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    RefreshableScrollView(onRefresh: { done in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            homeViewModel.post()
                            homeViewModel.GetTagList()
                            done()
                        }
                    }) {
                        VStack(spacing: 0) {
                            TagSelectList(
                                tags: $homeViewModel.tagList
                            )
                            
                            ForEach(homeViewModel.postList, id: \.post_id) { data in
                                PostForm(
                                    close: $isClose,
                                    postData: data
                                )
                                .padding(.horizontal, 14)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                    .onAppear() {
                        DispatchQueue.global().async {
                            homeViewModel.GetTagList()
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
                .padding(.top, 10)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
