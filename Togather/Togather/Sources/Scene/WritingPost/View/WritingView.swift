import SwiftUI
import SwiftUIFlowLayout

struct WritingView: View {
    
    @Binding var showModal: Bool

    @State var tagBtnArr: [String] = []
    @State var goTags: Bool = false
    
    @StateObject var postViewModel = PostViewModel()
    
    var body: some View {
        VStack {
            //MARK: - 취소버튼

            HStack {
                Spacer()
                Image("CloseBtn")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.top, 16)
                    .onTapGesture {
                        self.showModal.toggle()
                    }
            }
            
            //MARK: - 제목

            WritingTextField(
                placeholder: "제목",
                text: $postViewModel.title
            )
            
            //MARK: - 링크

            WritingTextField(
                placeholder: "연락받을 링크",
                text: $postViewModel.link
            )
            
            //MARK: - 본문

            WritingTextEditor(
                text: $postViewModel.content,
                placeholder: "본문을 입력하세요"
            )
            
            FlowLayout(mode: .scrollable,
                       items: tagBtnArr,
                       itemSpacing: 2) { index in
                
                Text(index)
                    .foregroundColor(.white)
                    .font(.maintext2m)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.whiteElevated5)
                    .cornerRadius(37)
                    .padding(1)
                    .background(Color.whiteElevated4)
                    .cornerRadius(37)
            }
            
            //MARK: - 글쓰기 버튼
            
            HStack {
                WritingButton(
                    title: "글쓰기",
                    backgroundColor: .main,
                    cornerColor: .mainDarken,
                    action: {
                        postViewModel.tag = self.tagBtnArr
                        postViewModel.post()
                        showModal = false
                    }
                )
                
                Spacer()
                
                WritingButton(
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
        .padding(.horizontal, 16)
        .padding(.bottom, 16)    } // body
}

struct Writing_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(showModal: .constant(true))
    }
}
