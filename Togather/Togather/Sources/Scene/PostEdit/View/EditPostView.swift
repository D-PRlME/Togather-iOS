import SwiftUI
import SwiftUIFlowLayout

struct EditPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var tagBtnArr: [String]
    @Binding var title: String
    @Binding var content: String
    @Binding var link: String
    var PostID: Int
    
    @State var goTags: Bool = false
    @StateObject var editPostViewModel = EditPostViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: - 취소버튼

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
            
            //MARK: - 제목

            PostTextField(
                placeholder: "제목",
                text: $title
            )
            
            //MARK: - 링크

            // 나중에 링크 없어지면 삭제
            PostTextField(
                placeholder: "연락받을 링크",
                text: $link
            )
            
            //MARK: - 본문

            PostTextEditor(
                text: $content,
                placeholder: "본문을 입력하세요"
            )
            
            //MARK: - 테그

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
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.whiteElevated4)
                    )
            }
            
            //MARK: - 글쓰기 버튼
            
            HStack {
                PostButton(
                    title: "저장",
                    backgroundColor: .main,
                    cornerColor: .mainDarken,
                    action: {
                        editPostViewModel.title = title
                        editPostViewModel.content = content
                        editPostViewModel.link = link
                        editPostViewModel.postID = PostID
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
        } //Vstack
        .padding([.horizontal, .bottom], 16)
        .navigationBarHidden(true)
    } // body
}


struct EditPostView_Preview: PreviewProvider {
    static var previews: some View {
        EditPostView(
            tagBtnArr: .constant(["Swift", "Backend"]),
            title: .constant("제목이져"),
            content: .constant("내용이죠"),
            link: .constant("링크이구요"),
            PostID: 1
        )
    }
}
