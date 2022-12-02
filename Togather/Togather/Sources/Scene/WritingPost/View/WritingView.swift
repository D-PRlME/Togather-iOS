import SwiftUI
import SwiftUIFlowLayout

struct WritingView: View {
    @Binding var showModal: Bool
    @State private var tagBtnArr: [String] = []
    @State private var goTags: Bool = false
    @StateObject var writingViewModel = WritingViewModel()
    var body: some View {
        BackgroundTapGesture {
            VStack {
                // MARK: - 취소버튼
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
                // MARK: - 제목

                PostTextField(
                    placeholder: "제목",
                    text: $writingViewModel.title
                )
                // MARK: - 본문

                PostTextEditor(
                    text: $writingViewModel.content,
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
                // MARK: - 글쓰기 버튼
                HStack {
                    PostButton(
                        title: "글쓰기",
                        backgroundColor: .main,
                        cornerColor: .mainDarken,
                        action: {
                            writingViewModel.tag = self.tagBtnArr
                            writingViewModel.post()
                            showModal = false
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
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    } // body
}

struct Writing_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(showModal: .constant(true))
    }
}
