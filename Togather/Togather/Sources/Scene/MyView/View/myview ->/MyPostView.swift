import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct MyPost: View {
    
    @State private var GoPostDetail = false
    @State private var isClose: Bool = false
    
    @StateObject var myPageViewModel = MyViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Image("CloseBtn")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.top, 16)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    ScrollView {
                        HStack {
                            Text("내 게시글 보기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 28))
                                .padding(.top, 40)
                            Spacer()
                        }
                        ForEach(myPageViewModel.postList, id: \.post_id) { data in
                            PostForm(
                                close: $isClose,
                                postData: data
                            )
                        }
                        .onChange(of: isClose) { newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    myPageViewModel.post()
                                    self.isClose = false
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .onAppear() {
            myPageViewModel.post()
        }
    }
}

struct MyPost_Previews: PreviewProvider {
    static var previews: some View {
        MyPost()
    }
}
