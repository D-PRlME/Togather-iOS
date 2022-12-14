import SwiftUI
import SwiftUIFlowLayout

struct EditPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var tagBtnArr: [String]
    @Binding var title: String
    @Binding var content: String
    @Binding var isEditing: Bool
    @State private var goTags: Bool = false
    @StateObject var editPostViewModel = EditPostViewModel()
    let postID: Int
    var body: some View {
        BackgroundTapGesture {
            VStack(alignment: .leading) {
                // MARK: - 취소버튼
                HStack {
                    Spacer()
                    Image("CloseBtn")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding([.top, .bottom], 16)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                // MARK: - 제목

                TitleTextField(
                    placeholder: "제목",
                    text: $title
                )
                // MARK: - 본문

                ContentTextEditor(
                    text: $content,
                    placeholder: "본문을 입력하세요"
                )
                // MARK: - 테그

                FlowLayout(mode: .scrollable,
                           items: tagBtnArr,
                           itemSpacing: 4) { index in
                    Text(index)
                        .foregroundColor(.white0)
                        .font(.maintext2m)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.whiteElevated5)
                        .cornerRadius(37)
                }
                // MARK: - 글쓰기 버튼
                HStack {
                    PostButton(
                        title: "저장",
                        backgroundColor: .main,
                        cornerColor: .mainDarken,
                        action: {
                            self.isEditing = true
                            editPostViewModel.title = title
                            editPostViewModel.content = content
                            editPostViewModel.postID = postID
                            editPostViewModel.tag = tagBtnArr
                            editPostViewModel.edit()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                    Spacer()
                    PostButton(
                        title: "모든 태그 보기",
                        backgroundColor: .whiteElevated1,
                        cornerColor: .whiteElevated3,
                        action: {
                            goTags = true
                        }
                    )
                    .sheet(isPresented: $goTags) {
                        TagListView(goBack: $goTags, tagLists: $tagBtnArr)
                    }
                }
            } // Vstack
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    } // body
}

struct EditPostViewPreview: PreviewProvider {
    static var previews: some View {
        EditPostView(
            tagBtnArr: .constant(["Swift", "Backend"]),
            title: .constant(""),
            content: .constant(""),
            isEditing: .constant(false),
            postID: 1
        )
    }
}
