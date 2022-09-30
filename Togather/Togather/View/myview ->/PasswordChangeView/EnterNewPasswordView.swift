import SwiftUI

@available(iOS 16.0, *)
struct EnterNewPassword: View {
    
    @StateObject var changePWToEmailVM = ChangePasswordToEmailViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                NavigationLink(destination: ChangePasswordSuccess(), tag: 1, selection: $changePWToEmailVM.goSucced) { EmptyView() }
                Text("비밀번호 변경")
                    .font(.custom("Pretendard-Bold", size: 32))
                    .padding(.top, proxy.size.height / 6)
                    .padding(.bottom, 12)
                
                Text("바꿀 새 비밀번호를 입력해 주세요")
                    .font(.custom("Pretendard-Medium", size: 20))
                    .padding(.bottom, 42)
                    .allowsTightening(true)
                VStack {
                    SecureField("비밀번호", text: $changePWToEmailVM.newPassword)
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
                        Text("8자리 이상, 숫자, 영어 소문자, 특수문자를 포함해야 합니다 ")
                            .font(.custom("Pretendard-ExtraBold", size: 14))
                            .opacity(0.5)
                            .padding(.leading, 12)
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    changePWToEmailVM.ChangePassword()
                }) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(height: 0)
                        
                        Text("다음")
                            .font(.custom("Pretendard-Bold", size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 13)
                    .background(changePWToEmailVM.PasswordValueCheck() ? Color(red: 0.882, green: 0.678, blue: 0.004) : Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(6)
                    .padding(2)
                    .background(changePWToEmailVM.PasswordValueCheck() ? Color(red: 0.7, green: 0.6, blue: 0.004) : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                    .cornerRadius(8)
                    
                }
                .disabled(changePWToEmailVM.PasswordValueCheck() == false)
                .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 30 : 5)
            } //Vstack
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .navigationBarHidden(true)
    }
}

@available(iOS 16.0, *)
struct EnterNewPassword_Previews: PreviewProvider {
    static var previews: some View {
        EnterNewPassword()
    }
}
