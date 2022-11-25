import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct PostDetailView: View {
    @Binding var showModal: Bool
    @StateObject var postDetailViewModel = PostDetailViewModel()
    @State private var showingAlert = false
    @State private var isEdit = false
    let postID: Int
    var body: some View {
        NavigationView {
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
                        imageLink: postDetailViewModel.postDetail.user.profileImageUrl,
                        userName: postDetailViewModel.postDetail.user.userName,
                        createdAt: postDetailViewModel.postDetail.createdAt,
                        userID: postDetailViewModel.postDetail.user.userID
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
                    // MARK: - 본문
                    Text(postDetailViewModel.postDetail.content)
                        .foregroundColor(.text)
                        .font(.maintext1m)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    // MARK: - 버튼들
                    HStack(alignment: .bottom) {
                        if !postDetailViewModel.postDetail.isMine {
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
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Spacer()
                            Button {
                                switch postDetailViewModel.postDetail.isLiked {
                                case true:
                                    postDetailViewModel.postDetail.likeCount -= 1
                                    postDetailViewModel.dislike()
                                case false:
                                    postDetailViewModel.like()
                                    postDetailViewModel.postDetail.likeCount += 1
                                }
                                postDetailViewModel.postDetail.isLiked.toggle()
                            } label: {
                                HStack(spacing: 0) {
                                    Text(String(postDetailViewModel.postDetail.likeCount))
                                        .foregroundColor(.text)
                                        .font(.maintext1m)
                                    Image(postDetailViewModel.postDetail.isLiked ? "OnHeart" : "OffHeart")
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
                                if postDetailViewModel.postDetail.isMine {
                                    NavigationLink(destination: EditPostView(
                                        tagBtnArr: $postDetailViewModel.tagName,
                                        title: $postDetailViewModel.postDetail.title,
                                        content: $postDetailViewModel.postDetail.content,
                                        isEditing: $isEdit,
                                        postID: postID)
                                    ) {
                                        Text("수정")
                                            .foregroundColor(.text)
                                            .font(.maintext1b)
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
                                    PostButton(
                                        title: "삭제",
                                        backgroundColor: .error,
                                        cornerColor: .redDarken,
                                        action: {
                                            showingAlert.toggle()
                                        }
                                    )
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
            .alert("게시물 삭제", isPresented: $showingAlert) {
                Button("삭제", role: .destructive) {
                    postDetailViewModel.delete()
                    showModal.toggle()
                }
                Button("취소", role: .cancel) { }
            } message: {
                Text("정말로 삭제하시겠습니까?")
            }
            .redacted(reason: postDetailViewModel.showSkeleton ? .placeholder : [])
            .onAppear {
                postDetailViewModel.postID = postID
                if !self.isEdit {
                    postDetailViewModel.getPostDetail()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        postDetailViewModel.getPostDetail()
                    }
                    self.isEdit = false
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(showModal: .constant(true), postID: 1)
    }
}
