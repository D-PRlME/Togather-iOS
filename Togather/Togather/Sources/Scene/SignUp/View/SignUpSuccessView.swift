import SwiftUI
import SwiftKeychainWrapper

struct SignUpSuccessView: View {
    @StateObject var signUpSuccessViewModel = SignUpSuccessViewModel()
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    var body: some View {
        GeometryReader { proxy in
            NavigationLink(
                destination: TabBarView(),
                tag: 3,
                selection: $signUpSuccessViewModel.isSuccess
            ) { EmptyView() }
            VStack(alignment: .leading) {
                // MARK: - Title
                Text("가입이\n완료되었어요")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.top, proxy.size.height / 6)
                GeometryReader { imageProxy in
                    Image("GreenCheck")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: imageProxy.frame(in: .local).midX, y: imageProxy.frame(in: .local).midY)
                }
                // MARK: - Button
                AuthButton(
                    text: "다음",
                    action: {
                        signUpSuccessViewModel.email = email
                        signUpSuccessViewModel.password = password
                        signUpSuccessViewModel.name = name
                        signUpSuccessViewModel.signUpClient()
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .navigationBarHidden(true)
    }
}

struct SignUpSuccess_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSuccessView(
            email: .constant("dsffsf"),
            password: .constant("safsd"),
            name: .constant("fasfd")
        )
    }
}
