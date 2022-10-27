import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct PostDetail: View {
    
    @Binding var showModal: Bool
    var postID: Int
    
    @StateObject var postDetailViewModel = PostDetailViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    ColorManager.BackgroundColor.ignoresSafeArea()
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
                        .unredacted()
                        
                        PostInfoForm(
                            title: postDetailViewModel.postDetail.title,
                            imageLink: postDetailViewModel.postDetail.user.profile_image_url,
                            userName: postDetailViewModel.postDetail.user.user_name,
                            createdAt: postDetailViewModel.postDetail.created_at
                        )
                        
                        Divider()
                        
                        FlowLayout(mode: .scrollable,
                                   items: postDetailViewModel.postDetail.tags,
                                   itemSpacing: 4) {
                            Text($0.name)
                                .foregroundColor(.text)
                                .font(.maintext2m)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.whiteElevated1)
                                .cornerRadius(37)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 37)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(.whiteElevated3)
                                )
                        }
                        
                        Text(postDetailViewModel.postDetail.content)
                            .foregroundColor(.text)
                            .font(.maintext2m)
                        Spacer()
                        HStack(alignment: .bottom) {
                            HStack(spacing: 8) {
                                Image("LinkImage")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .padding(4)
                                Text("연락하기")
                                    .foregroundColor(.black)
                                    .font(.maintext1b)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.main)
                            .cornerRadius(37)
                            .overlay(
                                RoundedRectangle(cornerRadius: 37)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.mainDarken)
                            )
                            Spacer()
                            VStack(alignment: .trailing) {
                                Spacer()
                                Button {
                                    switch postDetailViewModel.postDetail.is_liked {
                                    case true:
                                        postDetailViewModel.postDetail.like_count -= 1
                                        postDetailViewModel.dislike()
                                    case false:
                                        postDetailViewModel.postDetail.like_count += 1
                                        postDetailViewModel.like()
                                    }
                                    postDetailViewModel.postDetail.is_liked.toggle()
                                } label: {
                                    HStack(spacing: 0) {
                                        Text(String(postDetailViewModel.postDetail.like_count))
                                            .foregroundColor(.text)
                                            .font(.maintext1m)
                                        Image(postDetailViewModel.postDetail.is_liked ? "OnHeart" : "OffHeart")
                                            .resizable()
                                            .frame(width: 20, height: 17)
                                            .padding(.leading, 4)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.whiteElevated1)
                                    .cornerRadius(37)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 37)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.whiteElevated3)
                                    )
                                }
                                HStack {
                                    if postDetailViewModel.postDetail.is_mine {
                                        NavigationLink(destination: EditPostView(
                                            tagBtnArr: $postDetailViewModel.tagName,
                                            title: $postDetailViewModel.postDetail.title,
                                            content: $postDetailViewModel.postDetail.content,
                                            link: $postDetailViewModel.postDetail.link)) {
                                            Text("수정")
                                                    .foregroundColor(.text)
                                                    .font(.maintext1b)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(Color.whiteElevated1)
                                                .cornerRadius(37)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 2)
                                                        .stroke(lineWidth: 2)
                                                        .foregroundColor(.whiteElevated3)
                                                )
                                        }
                                        
                                        Button {
                                            postDetailViewModel.delete()
                                            showModal.toggle()
                                        } label: {
                                            Text("삭제")
                                                .foregroundColor(.text)
                                                .font(.maintext1b)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 8)
                                                .background(Color.error)
                                                .cornerRadius(37)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 37)
                                                        .stroke(lineWidth: 2)
                                                        .foregroundColor(Color("RedStroke"))
                                                )
                                        }
                                    }
                                }
                            }
                            .unredacted()
                        }
                        .unredacted()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .redacted(reason: postDetailViewModel.showSkeleton ? .placeholder : [])
            }
            .onAppear {
                postDetailViewModel.postID = postID
                postDetailViewModel.getPostDetail()
            }
            .navigationBarHidden(true)
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(showModal: .constant(true), postID: 1)
    }
}
