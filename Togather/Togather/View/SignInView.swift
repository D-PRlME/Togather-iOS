import SwiftUI

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ColorManager.BackgroundColor1.ignoresSafeArea()
                NavigationLink(destination: TabBarView(), tag: 1, selection: $loginViewModel.viewTag ) { EmptyView() }
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("마음 맞는 팀원을 찾는\n간단한 방법.")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Bold", size: 32))
                            .multilineTextAlignment(.leading)
                        Text("Togather")
                            .foregroundColor(Color("TabBarSelectedColor"))
                            .font(.custom("Pretendard-Bold", size: 32))
                    }
                    
                    TextField("이메일", text: $email)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color("TabBarStroke"))
                        .cornerRadius(6)
                    
                    SecureField("비밀번호", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color("TabBarStroke"))
                        .cornerRadius(6)
                    
                    
                    Button(action: {
                        loginViewModel.email = email
                        loginViewModel.password = password
                        
                        loginViewModel.Login()
                    }) {
                        Text("로그인")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(.black)
                            .padding(.vertical, 12)
                            .frame(width: UIScreen.main.bounds.width - 32)
                            .background(Color("TabBarSelectedColor"))
                            .cornerRadius(6)
                            .padding(2)
                            .background(Color("YellowStroke"))
                            .cornerRadius(6)
                    }
                    
                    HStack(spacing: 12) {
                        Spacer()
                        NavigationLink (destination: SignUpView()) {
                            Text("회원가입")
                                .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                                .font(.custom("Pretendard-Medium", size: 18))
                                .padding(.vertical, 13)
                        }
                        Spacer()
                        Text("비밀번호 변경")
                            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
                            .font(.custom("Pretendard-Medium", size: 18))
                            .padding(.vertical, 13)
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
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
