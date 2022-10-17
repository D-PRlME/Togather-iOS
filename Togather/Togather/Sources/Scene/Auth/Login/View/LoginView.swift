import SwiftUI

@available(iOS 16.0, *)
@available(iOS 16.0, *)
struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    @StateObject var loginViewModel = LoginViewModel()

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor.ignoresSafeArea()
                NavigationLink(destination: TabBarView(), tag: 1, selection: $loginViewModel.viewTag ) { EmptyView() }
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                    LoginTitle()
                    
                    AuthTextFiled(
                        placeholder: "이메일",
                        isSecret: false,
                        text: $email
                    )
                    
                    AuthTextFiled(
                        placeholder: "비밀번호",
                        isSecret: true,
                        text: $password
                    )
                    
                    AuthButton(
                        text: "로그인",
                        action: {
                            loginViewModel.email = email
                            loginViewModel.password = password
                            loginViewModel.showProgrees = true
                            loginViewModel.login()
                        }
                    )
                    
                    HStack(spacing: 12) {
                        Spacer()
                        NavigationLink (destination: SignUpView()) {
                            Text("회원가입")
                                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.vertical, 13)
                        }
                        Spacer()
                        NavigationLink(destination: ChangePasswordVerify()) {
                            Text("비밀번호 변경")
                                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.vertical, 13)
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 12) {
                        Spacer()
                        Image("GoogleLogo")
                            .resizable()
                            .frame(width: 48, height: 48)
                        Image("AppleLogo")
                            .resizable()
                            .frame(width: 48, height: 48)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .alert("안내", isPresented: $loginViewModel.showError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(loginViewModel.errorMessage)
            }
        }
        .navigationBarHidden(true)
    }
}

@available(iOS 16.0, *)
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
