import SwiftUI
import SwiftUIFlowLayout

struct WritingView: View {
    
    @Binding var showModal: Bool

    @State var tagBtnArr: [String] = []
    
    @StateObject var postViewModel = PostViewModel()
    
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
                        self.showModal.toggle()
                    }
            }
            
            //MARK: - 제목

            TextField("제목", text: $postViewModel.title)
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
                TextField("연락받을 링크", text: $postViewModel.link)
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
                TextEditor(text: $postViewModel.content)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.top, 12)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(4)
                    .padding(1)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(6)
                
                
                if(self.postViewModel.content.count <= 0) {
                    Text("본문을 입력하세요")
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                        .padding(.leading, 15)
                        .padding(.top, 20)
                } //플레이스 홀더
            }
            
            FlowLayout(mode: .scrollable,
                       items: postViewModel.tagListName,
                       itemSpacing: 0) {index in
                
                Button {
                    if tagBtnArr.contains(index) {
//                        withAnimation {
//                            tagBtnArr.removeAll(where: { $0 == index })
//                        }
                        tagBtnArr.removeAll(where: { $0 == index })
                    } else {
//                        withAnimation {
//                            tagBtnArr.append(index)
//                        }
                        tagBtnArr.append(index)
                    }
                } label: {
                    Text(index)
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(tagBtnArr.contains(index) ?
                                    Color(red: 0.924, green: 0.792, blue: 0.356) :
                                        Color(red: 0.905, green: 0.905, blue: 0.905))
                        .cornerRadius(37)
                        .padding(1)
                        .background(tagBtnArr.contains(index) ?
                                    Color("YellowStroke") :
                                        Color("TabBarStroke"))
                        .cornerRadius(37)
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                }
            }
            
            //MARK: - 글쓰기 버튼

            HStack {
                Button(action: {
                    postViewModel.tag = self.tagBtnArr
                    postViewModel.post()
                    showModal = false
                }) {
                    Text("글쓰기")
                        .font(.custom("Pretendard-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
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
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
            postViewModel.GetTagList()
        }
    } // body
}

struct Writing_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(showModal: .constant(true))
    }
}
