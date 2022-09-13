import SwiftUI

struct SignUpView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var nameText: String = ""
    
    @StateObject var signUpViewModel = SignUpViewModel()
    @StateObject var emailDuplicateViewModel = EmailDuplicateViewModel()
    
    //MARK: - 버튼 활성화 여부 함수

    private func ButtonAtivation() -> Bool {
        if emailText.count > 0 && passwordText.count > 0 && nameText.count > 0 {
            return true
        } else {
            return false
        }
    }
    //MARK: - body

    var body: some View {
        GeometryReader { proxy in
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
                        .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                        .cornerRadius(6)
                    HStack {
                        Text("dsm.hs.kr 도메인을 사용하는 이메일을 사용하세요")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-ExtraBold", size: 14))
                            .opacity(0.5)
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
                        .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                        .cornerRadius(6)
                    HStack {
                        Text("8자리 이상, 숫자, 영어 소문자, 특수문자를 포함해야 합니다")
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-ExtraBold", size: 14))
                            .opacity(0.5)
                            .padding(.leading, 12)
                            .padding(.bottom, 12)
                        Spacer()
                    }
                }
                
                TextField("이름", text: $nameText)
                    .foregroundColor(.black)
                    .keyboardType(.namePhonePad)
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
                    emailDuplicateViewModel.email = emailText
                    emailDuplicateViewModel.emailDuplicate()
                }) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 0)
                        
                        Text("다음")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 13)
                    .background(ButtonAtivation() ? Color(red: 0.882, green: 0.678, blue: 0.004) : Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(6)
                    .padding(2)
                    .background(ButtonAtivation() ? Color(red: 0.7, green: 0.6, blue: 0.004) : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(8)
                }
                .disabled(ButtonAtivation() == false)
            } //Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    } //body
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
