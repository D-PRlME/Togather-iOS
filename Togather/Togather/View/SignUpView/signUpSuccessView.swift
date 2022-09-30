import SwiftUI

@available(iOS 16.0, *)
struct signUpSuccess: View {
    
    @StateObject var signUpVM = SignUpViewModel()
    
    var userEmail: String = ""
    var password: String = ""
    var name: String = ""
    
    init(_ email: String, _ password: String, _ name: String) {
        self.userEmail = email
        self.password = password
        self.name = name
    }
    
    var body: some View {
        GeometryReader { proxy in
            NavigationLink(destination: TabBarView(), tag: 1, selection: $signUpVM.isSuccess ) { EmptyView() }
            VStack(alignment: .leading) {
                Text("가입이\n완료되었어요")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.top, proxy.size.height / 5)
                
                GeometryReader { imageProxy in
                    Image("GreenCheck")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: imageProxy.frame(in: .local).midX, y: imageProxy.frame(in: .local).midY)
                }
                
                Button(action: {
                    signUpVM.email = userEmail
                    signUpVM.password = password
                    signUpVM.name = name
                    
                    signUpVM.signUpClient()
                }) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 0)
                        
                        Text("다음")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 13)
                    .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                    .cornerRadius(6)
                    .padding(2)
                    .background(Color(red: 0.7, green: 0.6, blue: 0.004))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .navigationBarHidden(true)
    }
}

//struct signUpSuccess_Previews: PreviewProvider {
//    static var previews: some View {
//        signUpSuccess()
//    }
//}
