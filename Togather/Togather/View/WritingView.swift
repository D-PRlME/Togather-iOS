
import SwiftUI
import SwiftUIFlowLayout

struct WritingView: View {
    @State var titleText: String = ""
    @State var linkText: String = ""
    @State var contentText: String = ""
    
    @StateObject var postViewModel = PostViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    } //textEditor 기본배경 지우기 (안하면 배경색이 적용 안됨)
    
    var body: some View {
        VStack {
            
            //MARK: - 취소버튼

            HStack {
                Spacer()
                Image("CloseBtn")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
            //MARK: - 제목

            TextField("제목", text: $titleText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.custom("Pretendard-Medium", size: 20))
                .foregroundColor(.black)
                .frame(height: 28)
                .padding(12)
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(4)
                .padding(1)
                .background(Color("TabBarStroke"))
                .cornerRadius(6)
            
            //MARK: - 링크

            HStack {
                TextField("연락받을 링크", text: $linkText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.black)
                    .frame(height: 28)
                
                Button( action: {
                    print("tooltip")
                }) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 22))
                        .foregroundColor(.secondary)
                        .padding(.trailing, 10)
                }
            }
            .padding(12)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(4)
            .padding(1)
            .background(Color("TabBarStroke"))
            .cornerRadius(6)
            
            //MARK: - 본문

            ZStack(alignment: .topLeading) {
                TextEditor(text: $contentText)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .padding(.leading, 10)
                    .padding(.top, 12)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(4)
                    .padding(1)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(6)
                
                
                if(self.contentText.count <= 0) {
                    Text("본문을 입력하세요")
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .padding(.leading, 15)
                        .padding(.top, 20)
                } //플레이스 홀더
            }
            
            TagsFlowLayout()
            //MARK: - 글쓰기 버튼

            HStack {
                Button(action: {
                    postViewModel.title = titleText
                    postViewModel.content = contentText
//                    postViewModel.tag =
                    postViewModel.link = linkText
                    
                    postViewModel.post()
                }) {
                    Text("글쓰기")
                        .font(.custom("Pretendard-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                        .cornerRadius(37)
                        .padding(2)
                        .background(Color("YellowStroke"))
                        .cornerRadius(37)
                }
                
                Spacer()
            }
            
        } //Vstack
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    } // body
}

struct Writing_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
