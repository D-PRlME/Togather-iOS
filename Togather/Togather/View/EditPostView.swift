import SwiftUI
import SwiftUIFlowLayout

struct EditPostView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var tagBtnArr: [String]
    
    @Binding var title: String
    @Binding var content: String
    @Binding var link: String
    
    @StateObject var postDetailViewModel = PostDetailViewModel()
    @StateObject var editPostViewModel = EditPostViewModel()
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
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
            //MARK: - 제목

            TextField("제목", text: $title)
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
                TextField("연락받을 링크", text: $link)
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
                TextEditor(text: $content)
                    .font(.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.top, 12)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(4)
                    .padding(1)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(6)
                
                
                if(self.content.count <= 0) {
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
                       items: postViewModel.tagList,
                       itemSpacing: 0) {index in
                
                Button {
                    if tagBtnArr.contains(index.name) {
//                        withAnimation {
//                            tagBtnArr.removeAll(where: { $0 == index })
//                        }
                        tagBtnArr.removeAll(where: { $0 == index.name })
                    } else {
//                        withAnimation {
//                            tagBtnArr.append(index)
//                        }
                        tagBtnArr.append(index.name)
                    }
                } label: {
                    Text(index.name)
                        .foregroundColor(.black)
                        .font(.custom("Pretendard-Medium", size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(tagBtnArr.contains(index.name) ?
                                    Color(red: 0.924, green: 0.792, blue: 0.356) :
                                        Color(red: 0.905, green: 0.905, blue: 0.905))
                        .cornerRadius(37)
                        .padding(1)
                        .background(tagBtnArr.contains(index.name) ?
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
                    editPostViewModel.title = title
                    editPostViewModel.content = content
                    editPostViewModel.link = link
                    for i in 1..<tagBtnArr.count - 1 {
                        editPostViewModel.tag.append(tagBtnArr[i])
                        print("tag 추가 \(tagBtnArr[i])")
                    }
                    postViewModel.tag = self.tagBtnArr
                    editPostViewModel.edit()
                }) {
                    Text("저장")
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
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
            editPostViewModel.postID = UserDefaults.standard.integer(forKey: "postID")
            postDetailViewModel.postID = UserDefaults.standard.integer(forKey: "postID")
            postViewModel.GetTagList()
            
            print("Edit -> postDetail.getpostdetail()")
            
            postDetailViewModel.getPostDetail()
        }
        .navigationBarHidden(true)
    } // body
}
//
//struct EditPostView_Preview: PreviewProvider {
//    static var previews: some View {
//        EditPostView()
//    }
//}
