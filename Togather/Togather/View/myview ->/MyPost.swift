import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

@available(iOS 16.0, *)
struct MyPost: View {
    
    @State var GoPostDetail = false
    
    @StateObject var myPageViewModel = MyViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Image("CloseBtn")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.top, 16)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    ScrollView {
                        HStack {
                            Text("내 게시글 보기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 28))
                                .padding(.top, 40)
                            Spacer()
                        }
                        ForEach(myPageViewModel.postList, id: \.post_id) { data in
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
                                .padding(.vertical, 6)
                            }
                            .sheet(isPresented: $GoPostDetail, content: {
                                PostDetail(
                                    showModal: self.$GoPostDetail
                                )
                            })
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .onAppear() {
            myPageViewModel.post()
        }
    }
}

@available(iOS 16.0, *)
struct MyPost_Previews: PreviewProvider {
    static var previews: some View {
        MyPost()
    }
}
