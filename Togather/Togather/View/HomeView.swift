
import SwiftUI
import SwiftUIFlowLayout
import Kingfisher
import Moya

var DevLanguage: [String] = ["Swift", "Java", "Kotlin", "JS", "Python", "Flutter"]
var DevColor: [Color] = [.orange, .red, .purple, .yellow, .green, .blue]
var Developer: [String] = ["홍승재", "길근우", "정승훈", "강용수", "김은오", "유찬홍"]

struct HomeView: View {
    
    @State var GoPostDetail = false
    
    @State var postList: [PostList] = []
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack() {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView() {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(homeViewModel.tagList, id: \.self) { index in
                                    VStack {
                                        KFImage.url(URL(string: index.image_url))
                                            .placeholder {
                                                Circle().fill(Color.secondary)
                                                    .frame(width: 56, height: 56)
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
                                }
                            }
                            .padding(.horizontal,  8)
                        }
                        Rectangle()
                            .foregroundColor(Color("TabBarStroke"))
                            .frame(width: proxy.size.width, height: 1)
                        ForEach(homeViewModel.postList, id: \.post_id) { data in
                            Button {
                                GoPostDetail = true
                                print("homeview :",data.post_id)
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
//                                        AsyncImage(url: URL(string: data.user_profile_image)) { image in
//                                            image
//                                                .resizable()
//                                                .scaledToFit()
//                                                .clipShape(Circle())
//                                        } placeholder: {
//                                            ProgressView()
//                                                .foregroundColor(.gray)
//                                        }
//
//                                        .frame(width: 33, height: 33)
                                        KFImage.url(URL(string: data.users.profile_image_url))
                                            .placeholder {
                                                Circle().fill(Color.secondary)
                                            }
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 33, height: 33)
                                            .cornerRadius(20)
                                            .padding(.horizontal, 4)
                                            .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                        
                                        Text(data.users.user_name)
                                            .foregroundColor(.black)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        Spacer()
                                        Text(data.created_at)
                                            .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47, opacity: 1))
                                            .font(.custom("Pretendard-Medium", size: 16))
                                    }
                                }
                                .padding(12)
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                            .sheet(isPresented: $GoPostDetail, content: {
                                PostDetail(
                                    showModal: self.$GoPostDetail
                                )
                            })
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 86 : 106)
                    .onAppear() {
                        homeViewModel.post()
                        homeViewModel.GetTagList()
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
