import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct PostDetail: View {
    @Binding var showModal: Bool
    
    @StateObject var postDetailViewModel = PostDetailViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Spacer()
                        Image("CloseBtn")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.top, 16)
                            .onTapGesture {
                                showModal.toggle()
                            }
                    }
                    Text(postDetailViewModel.postDetail.title)
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Bold", size: 24))
                    
                        .padding(.top, 7)
                    HStack(spacing: 8) {
                        KFImage.url(URL(string: postDetailViewModel.postDetail.user.profile_image_url))
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

                        Text(postDetailViewModel.postDetail.user.user_name)
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Medium", size: 16))
                        Spacer()
                        Text(postDetailViewModel.postDetail.created_at)
                            .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47, opacity: 1))
                            .font(.custom("Pretendard-Medium", size: 16))
                    }
                    
                    Rectangle()
                        .foregroundColor(Color("TabBarStroke"))
                        .frame(width: proxy.size.width - 32, height: 1)
                    
                    FlowLayout(mode: .scrollable,
                               items: postDetailViewModel.postDetail.tags,
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
                    
                    Text(postDetailViewModel.postDetail.content)
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 18))
                    Spacer()
                    HStack {
                        HStack(spacing: 8) {
                            Image("LinkImage")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(4)
                            Text("연락하기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                        }
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                        .cornerRadius(37)
                        .padding(2)
                        .background(Color("YellowStroke"))
                        .cornerRadius(37)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .onAppear() {
            print("postdetail:", UserDefaults.standard.integer(forKey: "postID"))
            postDetailViewModel.postID = UserDefaults.standard.integer(forKey: "postID")
            postDetailViewModel.getPostDetail()
        }
    }
}

//struct PostDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetail(postID: .constant(1), showModal: .constant(true))
//    }
//}
