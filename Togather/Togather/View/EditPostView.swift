import SwiftUI
import SwiftUIFlowLayout

struct EditPostView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var tagBtnArr: [String]
    
    @Binding var title: String
    @Binding var content: String
    @Binding var link: String
    
    @State var goTags: Bool = false
    
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
//                    .scrollContentBackground(.hidden)
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
                       items: tagBtnArr,
                       itemSpacing: 0) { index in
                
                Text(index)
                    .foregroundColor(.white)
                    .font(.custom("Pretendard-Medium", size: 16))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.254, green: 0.254, blue: 0.254))
                    .cornerRadius(37)
                    .padding(1)
                    .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(37)
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
            }
            
            //MARK: - 글쓰기 버튼

            HStack {
                Button(action: {
                    editPostViewModel.title = title
                    editPostViewModel.content = content
                    editPostViewModel.link = link
//                    for i in 0..<tagBtnArr.count {
//                        editPostViewModel.tag.append(tagBtnArr[i])
//                        print("tag 추가 \(tagBtnArr[i])")
//                    }
                    editPostViewModel.tag.append(contentsOf: tagBtnArr.map { data in
                        print("tag 추가 \(data)")
                        return data
                    })
                    postViewModel.tag = self.tagBtnArr
                    editPostViewModel.edit()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("저장")
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
                
                Button {
                   //모든 태그 보기 누름
                    goTags = true
                } label: {
                    HStack {
                        Text("모든 태그 보기")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Bold", size: 18))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(37)
                            .padding(2)
                            .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                            .cornerRadius(37)
                    }
                }
                .padding(.leading, 3)
                .sheet(isPresented: $goTags) {
                    TagListView(goBack: $goTags, tagLists: $tagBtnArr)
                }
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
