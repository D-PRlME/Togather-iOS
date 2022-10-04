import SwiftUI

@available(iOS 16.0, *)
struct SignUpView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var nameText: String = ""
    
    @StateObject var emailDuplicateVM = EmailDuplicateViewModel()
    @StateObject var signUpValueCheckVM = SignUpValueCheckViewModel()
    
    //MARK: - body
    
    var body: some View {
        
        GeometryReader { proxy in
            NavigationLink(destination: EmailVerify(emailText, passwordText, nameText), tag: 1, selection: $emailDuplicateVM.viewTag) { EmptyView() }
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("ToGathrer")
                            .font(.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(Color("TabBarSelectedColor"))
                        Text("시작하기")
                            .font(.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.black)
                    }
                    .padding(.top, proxy.size.height / 6)
                    .padding(.bottom, 50)
                    
                    //MARK: - textFileds
                    
                    VStack(spacing: 8) {
                        TextField("이메일", text: $emailText)
                            .foregroundColor(.black)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .frame(height: 28)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(4)
                            .padding(1)
                            .background(signUpValueCheckVM.EmailValueCheck(emailText) ? Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15) : .red)
                            .cornerRadius(6)
                        HStack {
                            Text("dsm.hs.kr 도메인을 사용하는 이메일을 사용하세요")
                                .foregroundColor(signUpValueCheckVM.EmailValueCheck(emailText) ? Color.black.opacity(0.5) : .red)
                                .font(.custom("Pretendard-ExtraBold", size: 14))
                                .padding(.leading, 12)
                                .padding(.bottom, 12)
                            Spacer()
                        }
                    }
                    
                    VStack(spacing: 8) {
                        SecureField("비밀번호", text: $passwordText)
                            .foregroundColor(.black)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .frame(height: 28)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(4)
                            .padding(1)
                            .background(signUpValueCheckVM.PasswordValueCheck(passwordText) ? Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15) : .red)
                            .cornerRadius(6)
                        HStack {
                            Text("8자리 이상, 숫자, 영어 소문자, 특수문자를 포함해야 합니다")
                                .foregroundColor(signUpValueCheckVM.PasswordValueCheck(passwordText) ? Color.black.opacity(0.5) : .red)
                                .font(.custom("Pretendard-ExtraBold", size: 14))
                                .padding(.leading, 12)
                                .padding(.bottom, 12)
                            Spacer()
                        }
                    }
                    
                    TextField("이름", text: $nameText)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .frame(height: 28)
                        .padding(12)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(4)
                        .padding(1)
                        .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                        .cornerRadius(6)
                    Spacer()
                    
                    //MARK: - 다음 버튼
                    
                    Button(action: {
                        emailDuplicateVM.email = emailText
                        emailDuplicateVM.emailDuplicate()
                        
                    }) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .frame(height: 0)
                            
                            Text("다음")
                                .font(.custom("Pretendard-Bold", size: 18))
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 13)
                        .background(signUpValueCheckVM.CheckTotalSignUpValue(emailText, passwordText, nameText) ? Color(red: 0.882, green: 0.678, blue: 0.004) : Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(2)
                        .background(signUpValueCheckVM.CheckTotalSignUpValue(emailText, passwordText, nameText) ? Color(red: 0.7, green: 0.6, blue: 0.004) : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                        .cornerRadius(8)
                    }
                    .disabled(signUpValueCheckVM.CheckTotalSignUpValue(emailText, passwordText, nameText) == false)
                } //Vstack
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
                BackBtn()
            }
        }
        .navigationBarHidden(true)
        
        .alert("안내", isPresented: $emailDuplicateVM.showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(emailDuplicateVM.alertMessage)
        }
    } //body
}

@available(iOS 16.0, *)
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
