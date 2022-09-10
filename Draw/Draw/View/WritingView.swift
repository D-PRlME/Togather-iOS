
import SwiftUI

struct WritingView: View {
    @State var titleText: String = ""
    @State var linkText: String = ""
    @State var contentText: String = ""
    
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

            HStack {
                TextField("제목", text: $titleText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.custom("Pretendard-Medium", size: 20))
//                    .foregroundColor(Color("TabBarNoSelectedColor"))
                    .frame(height: 28)
                    .padding(.trailing, 5)
            }
            .padding(.leading, 12)
            .padding(.vertical, 10)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(4)
            .padding(2)
            .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
            .cornerRadius(6)
            .padding(.horizontal, 16)
                
            
            //MARK: - 링크

            HStack {
                TextField("연락받을 링크", text: $linkText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.custom("Pretendard-Medium", size: 20))
//                            .foregroundColor(Color("TabBarNoSelectedColor"))
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
            .padding(.leading, 12)
            .padding(.vertical, 10)
            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
            .cornerRadius(4)
            .padding(2)
            .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
            .cornerRadius(6)
            .padding(.horizontal, 16)
            
            //MARK: - 본문

            ZStack(alignment: .topLeading) {
                TextEditor(text: $contentText)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(4)
                    .padding(2.5)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(6)
                
                
                if(self.contentText.count <= 0) {
                    Text("본문을 입력하세요")
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .padding(EdgeInsets(top: 12, leading: 8, bottom: 0, trailing: 0))
                } //플레이스 홀더
            }
            .padding(.horizontal, 16)
            
            //MARK: - 글쓰기 버튼

            HStack {
                Button(action: {
                    print("글쓰기")
                }) {
                    Text("글쓰기")
                        .font(.custom("Pretendard-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                        .cornerRadius(37)
                }
                .padding(2)
                .background(Color(red: 0.7, green: 0.6, blue: 0.004))
                .cornerRadius(37)
                .padding(EdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 10))
                
                Spacer()
            }
            
        } //Vstack
    } // body
}

struct Writing_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
