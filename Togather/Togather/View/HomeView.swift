import SwiftUI
import SwiftUIFlowLayout
import Kingfisher
import Moya
import SwiftUIPullToRefresh

struct HomeView: View {
    @State var goPostDetail = false
    @State var goSearch = false
    @StateObject var homeViewModel = HomeViewModel()
    let animation = Animation
        .linear
        .repeatForever(autoreverses: false)
    var body: some View {
        GeometryReader { _ in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    RefreshableScrollView { done in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            homeViewModel.post()
                            homeViewModel.GetTagList()
                            done()
                        }) context: {
                        VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack {
                                    ForEach(homeViewModel.tagList, id: \.self) { index in
                                        VStack {
                                            KFImage.url(URL(string: index.image_url))
                                                .placeholder {
                                                    Circle().fill(Color.secondary)
                                                        .frame(width: 56, height: 56)
                                                        .opacity(0.1)
                                                }
                                                .resizable()
                                                .frame(width: 56, height: 56)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 4)
                                            Text(index.name)
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-ExtraBold", size: 14))
                                                .padding(.bottom, 9)
                                        }
                                        .onTapGesture {
                                            goSearch = true
                                            print(index.name)
                                        }
                                    }
                                }
                                .padding(.horizontal, 8)
                            }
                            Rectangle()
                                .foregroundColor(Color("TabBarStroke"))
                                .frame(width: proxy.size.width, height: 1)
                            ForEach(homeViewModel.postList, id: \.post_id) { data in
                                Button {
                                    goPostDetail = true
                                    print("homeview :", data.post_id)
                                    UserDefaults.standard.set(data.post_id, forKey: "postID")
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(data.title)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Bold", size: 24))
                                            .multilineTextAlignment(.leading)
                                            .padding(.leading, 5)
                                        FlowLayout(mode: .scrollable,
                                                   items: data.tags,
                                                   itemSpacing: 0) {
                                            Text($0.name)
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Medium", size: 16))
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(Color(red: 0.905, green: 0.905, blue: 0.905))
                                                .cornerRadius(37)
                                                .padding(1)
                                                .background(Color("TabBarStroke"))
                                                .cornerRadius(37)
                                                .padding(.trailing, 8)
                                                .padding(.bottom, 8)
                                        }
                                        Rectangle()
                                            .foregroundColor(Color("TabBarStroke"))
                                            .frame(width: proxy.size.width - 56, height: 1)
                                        HStack(spacing: 8) {
                                            KFImage.url(URL(string: data.users.profile_image_url))
                                                .placeholder {
                                                    Circle()
                                                        .fill(Color.secondary)
                                                        .opacity(0.1)
                                                }
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 33, height: 33)
                                                .cornerRadius(20)
                                                .padding(.horizontal, 4)
                                                .overlay(
                                                    Circle()
                                                        .stroke()
                                                        .foregroundColor(Color("TabBarStroke"))
                                                )
                                            Text(data.users.user_name)
                                                .foregroundColor(.black)
                                                .font(.custom("Pretendard-Medium", size: 16))
                                            Spacer()
                                            Image("GrayHeart")
                                                .resizable()
                                                .frame(width: 16, height: 13)
//                                                .padding(.trailing, 4)
                                            Text(String(data.like_count))
                                                .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47, opacity: 1))
                                                .font(.custom("Pretendard-Medium", size: 16))
                                            Image("SeperateBar")
                                                .resizable()
                                                .frame(width: 1, height: 15)
                                            Text(data.created_at)
                                                .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47, opacity: 1))
                                                .font(.custom("Pretendard-Medium", size: 16))
                                        }
                                    }
                                    .padding(12)
                                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                    .cornerRadius(8)
                                    .padding(.vertical, 6)
//                                    .animation(.linear)
                                }
                                .sheet(isPresented: $goPostDetail, content: {
                                    PostDetail(
                                        showModal: self.$goPostDetail
                                    )
                                    .onDisappear {
                                        homeViewModel.post()
                                    }
                                })
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                    .onAppear {
                        DispatchQueue.global().async {
                            homeViewModel.GetTagList()
                            homeViewModel.post()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
